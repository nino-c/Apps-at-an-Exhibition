from __future__ import unicode_literals

from django.db import models
from django.utils.timezone import now
from django_thumbs.db.models import ImageWithThumbsField


class PortfolioCategory(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)
    image = ImageWithThumbsField(null=True, sizes=((125,125),(200,200),(300,300)))
    
    def __unicode__(self):
        return self.name

    def num_items(self):
        items = PortfolioItem.objects.filter(category__id=self.id)
        return len(items)

class PortfolioItem(models.Model):
    category = models.ForeignKey(PortfolioCategory)
    title = models.CharField(max_length=100)
    subtitle = models.CharField(max_length=500, blank=True)
    url = models.CharField(max_length=150, null=True)
    description = models.TextField()
    sourcecode = models.CharField(null=True, blank=True, max_length=200)
    image = ImageWithThumbsField(null=True, sizes=((125,125),(200,200)))
    creationdate = models.DateField(auto_now=False, auto_now_add=False)

    def __unicode__(self):
        return self.title


class ImageGallery(models.Model):
    name = models.CharField(max_length=100)

    def __unicode__(self):
        return self.name

class ImageModel(models.Model):
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    timestamp = models.DateTimeField(default=now, editable=False)
    gallery = models.ForeignKey(ImageGallery, null=True, related_name='images')



class ProprietaryPortfolioItem(PortfolioItem):

    company = models.CharField(max_length=100)
    gallery = models.ForeignKey(ImageGallery)

    def __init__(self, *args, **kwargs):
        super(ProprietaryPortfolioItem, self).__init__(*args, **kwargs)

