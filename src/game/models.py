from __future__ import unicode_literals

import os
import os.path
import json

from django.db import models
#from jsonfield import JSONField
from django_thumbs.db.models import ImageWithThumbsField
from authtools.models import User

from django.conf import settings

class Category(models.Model):
    name = models.CharField(max_length=1000)
    description = models.TextField(null=True, blank=True)
    image = ImageWithThumbsField(null=True, blank=True, sizes=((125,125),(200,200),(300,300)))

    def __unicode__(self):
        return self.name


class ZeroPlayerGame(models.Model):
    owner = models.ForeignKey(User)
    title = models.CharField(max_length=500)
    description = models.TextField(blank=True)
    category = models.ForeignKey(Category)
    created = models.DateTimeField(auto_now=True)
    scriptName = models.CharField(max_length=500, null=True, blank=False)
    scriptType = models.CharField(max_length=100, null=True, blank=False)
    source = models.TextField(blank=True)
    seedStructure = models.TextField(blank=True)

    def __unicode__(self):
        return "\"%s\", by %s" % (self.title, self.owner.name)

    def instantiate(self, seed=None, user=None):
        if seed is None:
            seedDict = json.loads(self.seedStructure)
            seed = {k:v['default'] for k,v in seedDict.iteritems()}
        if user is None:
            user = self.owner
        inst = GameInstance(
            game=self,
            instantiator=user, 
            seed=json.dumps(seed), 
            source=self.source
            )
        inst.save()
        return inst


class GameInstance(models.Model):
    game = models.ForeignKey(ZeroPlayerGame, related_name='instances')
    instantiator = models.ForeignKey(User)
    timestamp = models.DateTimeField(auto_now_add=True, editable=False)
    seed = models.TextField()
    #source = models.TextField()
    pagecache = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.game.title, self.game.owner.name)

    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


class GameInstanceSnapshot(models.Model):
    instance = models.ForeignKey(GameInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)
    timestamp = models.DateTimeField(auto_now_add=True, editable=False)

    def getFilename(self):
        return self.image.name or None

class ImageTest(models.Model):
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))

    def saveimage(self, path):
        self.image.save(os.path.basename(path), File(path))
    
