from django.contrib import admin
from game.models import *


map(admin.site.register, [ZeroPlayerGame, Category, GameInstanceSnapshot])

# class GameParamsInline(admin.StackedInline):
# 	model = GameParam

# @admin.register(ZeroPlayerGame)
# class ZeroPlayerGame(admin.ModelAdmin):
# 	inlines = [
# 		GameParamsInline
# 	]

class ImagesInline(admin.StackedInline):
    model = GameInstanceSnapshot

@admin.register(GameInstance)
class GameInstance(admin.ModelAdmin):
    inlines = [
        ImagesInline,
    ]
