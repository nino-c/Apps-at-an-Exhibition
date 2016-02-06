from rest_framework import serializers

from .models import *

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    #apps = serializers.HyperlinkedIdentityField('apps', view_name="user-apps-list")
    class Meta:
        model = User
        fields = ('id', 'name',) # 'apps')

class InstanceSerializer(serializers.ModelSerializer):
    instantiator = UserSerializer(required=False)
    #app = serializers.HyperlinkedIdentityField('app')
    class Meta:
        model = AppInstance

class AppSerializer(serializers.ModelSerializer):
    owner = UserSerializer(required=False)
    category = CategorySerializer()
    instances = InstanceSerializer(many=True)
    class Meta:
        model = App
        fields = "__all__"