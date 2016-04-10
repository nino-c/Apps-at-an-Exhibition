from django.contrib import admin
from game.models import *


map(admin.site.register, [JSLibrary, ZeroPlayerGame, Category, 
		GameInstanceSnapshot, SavedFunction, CodeModule, SeedKeyVal])

# class GameParamsInline(admin.StackedInline):
# 	model = GameParam

# @admin.register(ZeroPlayerGame)
# class ZeroPlayerGame(admin.ModelAdmin):
# 	inlines = [
# 		GameParamsInline
# 	]

class ImagesInline(admin.StackedInline):
    model = GameInstanceSnapshot

# class SeedParamInline(admin.StackedInline):
#     model = SeedKeyVal

@admin.register(GameInstance)
class GameInstance(admin.ModelAdmin):
    inlines = [
        ImagesInline,
        #SeedParamInline
    ]
