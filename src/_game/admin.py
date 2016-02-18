from django.contrib import admin
from game.models import *


map(admin.site.register, [JSLibrary, App, Category])

# class GameParamsInline(admin.StackedInline):
# 	model = GameParam

# @admin.register(App)
# class App(admin.ModelAdmin):
# 	inlines = [
# 		GameParamsInline
# 	]

class ImagesInline(admin.StackedInline):
    model = Snapshot

@admin.register(AppInstance)
class AppInstance(admin.ModelAdmin):
    inlines = [
        ImagesInline,
    ]
