from __future__ import unicode_literals

from django.db import models
from django.utils.timezone import now
from django_thumbs.db.models import ImageWithThumbsField

from authtools.models import User

class Category(models.Model):
	name = models.CharField(max_length=1000)


class ZeroPlayerGame(models.Model):
	title = models.CharField(max_length=500)
	description = models.TextField(blank=True)
	owner = models.ForeignKey(User)
	category = models.ForeignKey(Category)
	created = models.DateTimeField(auto_now=True)