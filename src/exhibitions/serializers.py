from rest_framework import serializers

from .models import *

class serial_User(serializers.ModelSerializer):
    #apps = serializers.HyperlinkedIdentityField('apps', view_name="user-apps-list")

    class Meta:
        model = User
        fields = ('name',) # 'apps')

class serial_App(serializers.ModelSerializer):
    owner = serial_User(required=False)
    #instances = serializers.HyperlinkedIdentityField('instances', view_name="app-instance-list")

    class Meta:
        model = App