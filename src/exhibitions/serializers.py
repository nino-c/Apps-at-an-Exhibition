from rest_framework import serializers

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

# custom serializers
# ===========================================


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class SnapshotSerializer(serializers.ModelSerializer):
    created = ParseDateField()
    updated = ParseDateField()
    image = ImagesField()

    class Meta:
        model = Snapshot
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    avatar = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        exclude = ('password', 'last_login', 'is_superuser', 'email', 'is_staff', 'is_active', 'date_joined', 'groups', 'user_permissions',)
        read_only_fields = ('id', 'name', 'avatar')

    def get_avatar(self, object):
        return object.profile.picture.url

class InstanceSerializer(serializers.ModelSerializer):
    instantiator = UserSerializer(required=False, read_only=True)
    images = SnapshotSerializer(read_only=True, many=True)
    created = ParseDateField()
    updated = ParseDateField()

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['instantiator']

    class Meta:
        model = AppInstance
        include = ('images', 'created', 'updated',)
        read_only_fields = ('images', 'created', 'updated')


class AppSerializer(serializers.ModelSerializer):
    instances = InstanceSerializer(many=True, read_only=True)
    owner = UserSerializer(required=False, read_only=True)
    category = CategorySerializer(read_only=True)
    api_url = serializers.SerializerMethodField(read_only=True)
    created = ParseDateField()
    updated = ParseDateField()
    #mainImage = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = App
        include = ('api_url', 'created', 'updated')
        read_only_fields = ('id', 'created', 'updated', 'owner',
          'category', 'instances', 'api_url', 'mainImage')

    def get_validation_exclusions(self):
        exclusions = super(AppSerializer, self).get_validation_exclusions()
        return exclusions + ['owner']

    def get_api_url(self, obj):
        return "#/app/%s" % obj.id

    def update(self, instance, validated_data):
        print validated_data
        instance.source = validated_data.get('source', instance.source)
        instance.seedStructure = validated_data.get('seedStructure', instance.seedStructure)
        instance.save()
        return instance
