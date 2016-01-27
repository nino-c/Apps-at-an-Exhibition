from django.contrib import admin
from game.models import *


map(admin.site.register, [Category, ZeroPlayerGame, GameInstance, GameInstanceSnapshot])

# class ImagesInline(admin.StackedInline):
#     model = ImageModel

# @admin.register(ImageGallery)
# class ImageGallery(admin.ModelAdmin):
#     inlines = [
#         ImagesInline,
#     ]
