from django.contrib import admin
from exhibitions.models import *


map(admin.site.register, [Category, JSLibrary, App, AppInstance, Snapshot])

# class GameParamsInline(admin.StackedInline):
#   model = GameParam

# @admin.register(ZeroPlayerGame)
# class ZeroPlayerGame(admin.ModelAdmin):
#   inlines = [
#       GameParamsInline
#   ]

class ImagesInline(admin.StackedInline):
    model = Snapshot

# @admin.register(AppInstance)
# class AppInstance(admin.ModelAdmin):
#     inlines = [
#         ImagesInline,
#     ]
