from rest_framework import serializers
from .models import *
from authtools.models import User


# custom fields
# ===========================================

class ImagesField(serializers.Field):
    def to_representation(self, obj):
        return [im.image.name.replace("./","") for im in obj.all()]
    # def to_internal_value(self, data):
    #     return ','.split


# custom inline serializers
# ===========================================

class UserSerializer_Inline(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'name')

class SnapshotSerializer_Inline(serializers.ModelSerializer):
    class Meta:
        model = Snapshot

class AppInstanceSerializer_Inline(serializers.ModelSerializer):
    instantiator = UserSerializer_Inline()
    images = ImagesField(read_only=True)
    class Meta:
        model = AppInstance
        exclude = ('game',)
        depth = 1

# custom serializers
# ===========================================

class AppSerializer(serializers.ModelSerializer):
    instances = AppInstanceSerializer_Inline(many=True)
    owner = UserSerializer_Inline()
    
    class Meta:
        model = App
        depth = 1
        read_only_fields = ('instances', 'owner')

    def update(self, instance, validated_data):
        print validated_data
        instance.source = validated_data.get('source', instance.source)
        instance.seedStructure = validated_data.get('seedStructure', instance.seedStructure)
        instance.save()
        return instance

class AppInstanceSerializer(serializers.ModelSerializer):
    instantiator = UserSerializer_Inline()
    class Meta:
        model = AppInstance
        #depth = 1