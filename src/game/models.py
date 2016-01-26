from __future__ import unicode_literals

from django.db import models
from django.utils.timezone import now
from django_thumbs.db.models import ImageWithThumbsField

from authtools.models import User
#from .serializers import PlerpingAppSerializer

class Category(models.Model):
	name = models.CharField(max_length=1000)


class PlerpingApp(models.Model):
	title = models.CharField(max_length=500)
	description = models.TextField(blank=True)
	owner = models.ForeignKey(User)
	category = models.ForeignKey(Category)

	created = models.DateTimeField(auto_now=True)


# class ArtInstance(models.Model):
# 	game = models.ForeignKey('ZeroPlayerGame')
# 	seed = models.TextField() #


