from django.contrib import admin
from game.models import *


map(admin.site.register, [ZeroPlayerGame, Category, GameInstance, GameInstanceSnapshot])

# class GameParamsInline(admin.StackedInline):
# 	model = GameParam

# @admin.register(ZeroPlayerGame)
# class ZeroPlayerGame(admin.ModelAdmin):
# 	inlines = [
# 		GameParamsInline
# 	]

# class ImagesInline(admin.StackedInline):
#     model = ImageModel

# @admin.register(ImageGallery)
# class ImageGallery(admin.ModelAdmin):
#     inlines = [
#         ImagesInline,
#     ]
