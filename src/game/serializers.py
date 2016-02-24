from rest_framework import serializers
from authtools.models import User
from .models import *


def parseDate(d):
    #return {k:d.__getattribute__(k) for k in
    #['year', 'month', 'day', 'hour', 'minute', 'second']}
    return d.isoformat()


# custom fields
# ===========================================

class ImagesField(serializers.Field):
    def to_representation(self, obj):
        return [im.image.name.replace("./","") for im in obj.all()]

class ParseDateField(serializers.Field):
    def to_representation(self, obj):
        return parseDate(obj)

class CategoryField(serializers.Field):
    def to_representation(self, obj):
      return obj.__unicode__()
    def to_internal_value(self, data):
      return Category.objects.get(pk=int(data))


# custom serializers
# ===========================================


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class JSLibrarySerializer(serializers.ModelSerializer):
    class Meta:
        model = JSLibrary
        fields = '__all__'

class SnapshotSerializer(serializers.ModelSerializer):
    created = ParseDateField()
    updated = ParseDateField()

    class Meta:
        model = GameInstanceSnapshot
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    avatar = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        exclude = ('password', 'last_login', 'is_superuser', 'email', 'is_staff', 'is_active', 'date_joined', 'groups', 'user_permissions',)
        read_only_fields = ('id', 'name', 'avatar')

    def get_avatar(self, object):
        return object.profile.picture.url


class AppSerializer_Inline(serializers.ModelSerializer):

    class Meta:
        model = ZeroPlayerGame
        exclude = ('instances',)
        include = ('__all__')


class InstanceSerializer(serializers.ModelSerializer):
    instantiator = UserSerializer(required=False, read_only=True)
    #images = SnapshotSerializer(read_only=True, many=True)
    snapshots = serializers.SerializerMethodField(read_only=True)
    sourcecode = serializers.SerializerMethodField(read_only=True)
    #app = AppSerializer_Inline()
    #created = ParseDateField()
    #updated = ParseDateField()

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['instantiator']

    def get_sourcecode(self, object):
        return object.game.source

    def get_snapshots(self, object):
        return object.getImages()


    class Meta:
        model = GameInstance
        include = ('snapshots', 'created', 'updated', 'snapshots', 'app')
        read_only_fields = ('images', 'created', 'updated', 'snapshots')


class AppSerializer(serializers.ModelSerializer):
    instances = InstanceSerializer(many=True, read_only=True)
    owner = UserSerializer(required=False, read_only=True)
    category = CategoryField()
    extraIncludes = JSLibrarySerializer(read_only=True, many=True)

    class Meta:
        model = ZeroPlayerGame
        include = '__all__'
        read_only_fields = ('id', 'created', 'updated', 'owner',
          'instances')

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['owner']

    def get_api_url(self, obj):
        return "#/app/%s" % obj.id

    def update(self, instance, validated_data):
        instance.source = validated_data.get('source', instance.source)
        instance.seedStructure = validated_data.get('seedStructure', instance.seedStructure)
        instance.save()

    def create(self, validated_data):
        validated_data['owner'] = self.context['request'].user
        app = ZeroPlayerGame.objects.create(**validated_data)
        return app
