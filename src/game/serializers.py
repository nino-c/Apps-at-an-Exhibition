from rest_framework import serializers
from authtools.models import User
from .models import *


def parseDate(d):
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
        if type(data) == type(1):
            cat = Category.objects.get(pk=data)
        else:
            cat = Category.objects.get(name__exact=data)
        return cat

# class AppInlineField(serializers.Field):
#     def to_representation(self, obj):
#         return obj
#     def to_internal_value():
#         pass

# custom serializers
# ===========================================


class CategorySerializer(serializers.ModelSerializer):
    total_popularity = serializers.SerializerMethodField(read_only=True)
    avg_popularity = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Category
        fields = '__all__'

    def get_total_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all()))

    def get_avg_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all())) / object.apps.count()

class CodeModuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = CodeModule
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
        exclude = ('password', 'last_login', 'is_superuser', 'email', 'is_staff', 'is_active', 
            'date_joined', 'groups', 'user_permissions',)
        read_only_fields = ('id', 'name', 'avatar')

    def get_avatar(self, object):
        return object.profile.picture.url


class AppSerializer_Inline(serializers.ModelSerializer):
    required_modules = CodeModuleSerializer(many=True)

    class Meta:
        model = ZeroPlayerGame
        include = ('__all__')

class AppSerializer_Category_Inline(serializers.ModelSerializer):
    snapshots = serializers.SerializerMethodField(read_only=True)

    def get_snapshots(self, obj):
        snaps = []
        for inst in obj.instances.all():
            for im in inst.images.all():
                snaps.append(im.image.name.replace("./", ""))
        return snaps

    class Meta:
        model = ZeroPlayerGame
        exclude = ('source', 'seedStructure')
        #include = ('__all__')


class InstanceMixin(serializers.ModelSerializer):
    instantiator = UserSerializer(required=False, read_only=True)
    snapshots = serializers.SerializerMethodField(read_only=True)
    sourcecode = serializers.SerializerMethodField(read_only=True)

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['instantiator']

    def get_sourcecode(self, object):
        return object.game.source

    def get_snapshots(self, object):
        return object.getImages()

    def create(self, validated_data):
        validated_data['instantiator'] = self.context['request'].user
        validated_data['game'] = ZeroPlayerGame.objects.get(pk=validated_data['game_id'])
        del validated_data['game_id']
        instance = GameInstance(**validated_data)
        return instance

    

class InstanceSerializer(InstanceMixin, serializers.ModelSerializer):
    game = AppSerializer_Inline()

    class Meta:
        model = GameInstance
        include = ('snapshots', 'game', 'required_modules')
        read_only_fields = ('images', 'created', 'updated', 'snapshots')

class InstanceSerializer_Inline(InstanceMixin, serializers.ModelSerializer):

    class Meta:
        model = GameInstance
        include = ('snapshots', 'game')
        read_only_fields = ('images', 'created', 'updated', 'snapshots')





class AppSerializer(serializers.ModelSerializer):
    instances = InstanceSerializer_Inline(many=True, read_only=True)
    owner = UserSerializer(required=False, read_only=True)
    category = CategoryField()
    extraIncludes = JSLibrarySerializer(read_only=True, many=True)
    display_image = serializers.SerializerMethodField(read_only=True)
    snapshots = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ZeroPlayerGame
        depth = 2
        include = '__all__'
        read_only_fields = ('id', 'created', 'updated', 'owner',
          'instances', 'display_image')

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['owner']

    def get_snapshots(self, obj):
        snaps = []
        for inst in obj.instances.all():
            for im in inst.images.all():
                snaps.append(im.image.name.replace("./", ""))
        return snaps

    def get_api_url(self, obj):
        return "#/app/%s" % obj.id

    def get_display_image(self, obj):
        if obj.instances.count() > 0:
            for instance in obj.instances.all():
                if instance.images.count() > 0:
                    im = instance.images.all()[0]
                    return str(im.image.name).replace("./", "")
        return ""

    def update(self, app, validated_data):
        for k,v in validated_data.iteritems():
            app.__setattr__(k, v)
        #app.seedStructure = validated_data.get('seedStructure', app.seedStructure)
        app.save()
        return app

    def create(self, validated_data):
        validated_data['owner'] = self.context['request'].user
        app = ZeroPlayerGame.objects.create(**validated_data)
        return app


class CategoryAppsSerializer(serializers.ModelSerializer):
    apps = AppSerializer(read_only=True, many=True)
    total_popularity = serializers.SerializerMethodField(read_only=True)
    avg_popularity = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Category
        fields = '__all__'

    def get_total_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all()))

    def get_avg_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all())) / object.apps.count()