from rest_framework import serializers
from .models import ZeroPlayerGame

class ZeroPlayerGameSerializer(serializers.ModelSerializer):
	class Meta:
		model = ZeroPlayerGame

		
