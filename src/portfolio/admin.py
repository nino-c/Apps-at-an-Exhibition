from django.contrib import admin
from portfolio.models import *

admin.site.site_title = "plerp.org"
admin.site.site_header = "plerp.org"


map(admin.site.register, [PortfolioCategory, PortfolioItem, ProprietaryPortfolioItem])

class ImagesInline(admin.StackedInline):
    model = ImageModel

@admin.register(ImageGallery)
class ImageGallery(admin.ModelAdmin):
    inlines = [
        ImagesInline,
    ]
