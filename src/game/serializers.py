from rest_framework import serializers
from .models import ZeroPlayerGame, GameInstance
from authtools.models import User


class UserSerializer_Inline(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'name')

class GameInstanceSerializer_Inline(serializers.ModelSerializer):
    instantiator = UserSerializer_Inline()
    class Meta:
        model = GameInstance
        exclude = ('game',)
        depth = 1

class ZeroPlayerGameSerializer(serializers.ModelSerializer):
    instances = GameInstanceSerializer_Inline(many=True)
    owner = UserSerializer_Inline()
    class Meta:
        model = ZeroPlayerGame
        depth = 1


# class GameInstanceSerializer(serializers.ModelSerializer):
#     instantiator = UserSerializer_Inline()
#     class Meta:
#         model = GameInstance
#         depth = 2