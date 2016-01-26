from rest_framework import serializers
from .models import PlerpingApp

class PlerpingAppSerializer(serializers.ModelSerializer):
	class Meta:
		model = PlerpingApp
		fields = ('title', 'description', 'category', 'owner', 'created')
