from __future__ import unicode_literals

import os
import os.path
import json
import itertools
import random

from django.db import models
from django_thumbs.db.models import ImageWithThumbsField
from authtools.models import User

from django.conf import settings


class TimestamperMixin(object):
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

class Category(models.Model):
    name = models.CharField(max_length=1000)
    parent = models.ForeignKey('self', null=True, blank=True, related_name="children")
    description = models.TextField(null=True, blank=True)
    image = ImageWithThumbsField(null=True, blank=True, sizes=((125,125),(200,200),(300,300)))

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name_plural = "Categories"

class JSLibrary(models.Model):
    name = models.CharField(max_length=100, blank=False, null=False)
    scriptPath = models.CharField(max_length=200, blank=False, null=False)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name_plural = "JS libraries"

class App(TimestamperMixin, models.Model):
    parent = models.ForeignKey('self', null=True, blank=True, related_name="children")
    category = models.ForeignKey(Category)
    owner = models.ForeignKey(User, related_name="apps")
    title = models.CharField(max_length=500)
    description = models.TextField(blank=True)
    scriptType = models.CharField(max_length=100, null=True, blank=False)
    source = models.TextField(blank=True)
    seedStructure = models.TextField(blank=True)
    extraIncludes = models.ManyToManyField('JSLibrary', blank=True, related_name="included_in")

    def __unicode__(self):
        return "\"%s\", by %s" % (self.title, self.owner.name)

    def instantiate(self, request, seed=None):
        if seed is None:
            seedDict = json.loads(self.seedStructure)
            seed = {k:v['default'] for k,v in seedDict.iteritems()}
        if request.user is None:
            user = request.user
        else:
            user = self.owner
        inst = AppInstance(
            app=self,
            instantiator=user, 
            seed=json.dumps(seed), 
            )
        inst.save()
        return inst

    def chooseImageSet(order=4):
        images = map(lambda obj: obj.image.name.replace("./", ""), list(itertools.chain(
                    *map(lambda l: l.all(), 
                        [instance.images for instance in self.instances.all()]))
                    )
                )
        random.shuffle(images)
        return images[:order]


class AppInstance(TimestamperMixin, models.Model):
    app = models.ForeignKey(App, related_name='instances')
    instantiator = models.ForeignKey(User)
    seed = models.TextField()
    pagecache = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.app.title, self.app.owner.name)

    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


class Snapshot(TimestamperMixin, models.Model):
    instance = models.ForeignKey(AppInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)

    def __unicode__(self):
        return self.instance.app.title + ", " + str(self.timestamp)

    def getFilename(self):
        return self.image.name or None
