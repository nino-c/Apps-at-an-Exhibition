from __future__ import unicode_literals
from rest_framework import serializers
from authtools.models import User
from .models import *
import math
import json


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

class UserField(serializers.Field):
    def to_representation(self, obj):
        return obj.name


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
    images = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Category
        fields = '__all__'

    def get_total_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all()))

    def get_avg_popularity(self, object):
        return sum(map(lambda app: app.popularity, object.apps.all())) / object.apps.count()

    def get_images(self, object):
        images_per_app = 30 / object.apps.count()
        return reduce(lambda a,b: a + b, 
            map(lambda app: app.getImageSet(order=images_per_app), object.apps.all()))

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
    images = serializers.SerializerMethodField(read_only=True)

    def get_images(self, obj):
        snaps = []
        for inst in obj.instances.all():
            for im in inst.images.all():
                snaps.append(im.image.name.replace("./", ""))
        return snaps

    class Meta:
        model = ZeroPlayerGame
        exclude = ('source', 'seedStructure')
        #include = ('__all__')

class SeedVectorParamSerializer(serializers.ModelSerializer):
    class Meta:
        model = SeedVectorParam
        include = ('__all__',)


class InstanceMixin(serializers.ModelSerializer):
    
    instantiator = UserSerializer(required=False, read_only=True)
    sourcecode = serializers.SerializerMethodField(read_only=True)
    vectorparams = SeedVectorParamSerializer(many=True)

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['instantiator']

    def get_sourcecode(self, object):
        return object.game.source

    def get_images(self, object):
        return object.getImages()

    def update(self, instance, validated_data):
        instance = instance.record_seed_as_cols()
        instance.save()
        return instance



class InstanceSerializerMinimal(serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = GameInstance
        #include = ('images', 'vectorparams')
        exclude = ('instantiator', 'seed', 'game', 'popularity', 'vector')
        
    def get_images(self, object):
        return object.getImages()


class VectorParamSerializer(serializers.ModelSerializer):
    class Meta:
        model = SeedVectorParam
        include = ('key', 'val', 'int_val')
        exclude = ('id', 'jsonval', 'ordering', 'instance', 'app')


class OrderedInstanceSerializer(serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)
    vectorparams = VectorParamSerializer(many=True)

    class Meta:
        model = GameInstance
        #include = ('images', 'vectorparams')
        exclude = ('instantiator', 'game', 'popularity', 'vector')
        
    def get_images(self, object):
        return object.getImages()

class InstanceSerializer(InstanceMixin, serializers.ModelSerializer):
    game = AppSerializer_Inline()
    images = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = GameInstance
        include = '__all__'

    def get_images(self, obj):
        return obj.getImages()
        

class InstanceSerializer_Inline(InstanceMixin, serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = GameInstance
        include = ('images', 'game')
        read_only_fields = ('images', 'created', 'updated')

    def get_images(self, object):
        return object.getImages()



class AppSerializerBase(serializers.ModelSerializer):

    instances = InstanceSerializerMinimal(many=True, read_only=True)
    category = CategoryField()
    images = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ZeroPlayerGame
        exclude = ('category', 'source', 'seedStructure')

    def get_images(self, obj):
        snaps = []
        for inst in obj.instances.all():
            for im in inst.images.all():
                snaps.append(im.image.name.replace("./", ""))
        snaps.reverse()
        return snaps[:20]

class AppSerializer(AppSerializerBase):

    instances = InstanceSerializer_Inline(many=True, read_only=True)
    category = CategoryField()
    category_id = serializers.SerializerMethodField(read_only=True)
    extraIncludes = JSLibrarySerializer(read_only=True, many=True)
    display_image = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ZeroPlayerGame
        depth = 2
        include = '__all__'
        exclude = None
        read_only_fields = ('id', 'created', 'updated', 'owner',
          'instances', 'display_image', 'category_id')

    def get_validation_exclusions(self):
        exclusions = super(InstanceSerializer, self).get_validation_exclusions()
        return exclusions + ['owner']

    def get_api_url(self, obj):
        return "#/app/%s" % obj.id

    def get_category_id(self, obj):
        return obj.id

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

class AppSerializerMinimal(serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)
    seedstruct = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ZeroPlayerGame
        exclude = ('source',)

    def get_seedstruct(self, obj):
        return json.loads(obj.seedStructure)

    def get_instances(self, obj):
        return map(lambda inst: inst.id, obj.instances.all())

    def get_images(self, obj):
        return obj.getImageSet()

class AppSerializerNoInstances(serializers.ModelSerializer):
    category = CategoryField()
    owner = UserField()
    category_id = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = ZeroPlayerGame
        depth = 1
        exclude = ('source', 'seedStructure',)

    def get_category_id(self, obj):
        return obj.category.id;

class CategoryAppsSerializer(serializers.ModelSerializer):
    apps = AppSerializerMinimal(read_only=True, many=True)
    images_per_app = serializers.SerializerMethodField(read_only=True)

    def get_images_per_app(self, obj):
        return 20 / obj.apps.count()
        
    class Meta:
        model = Category
        fields = '__all__'


