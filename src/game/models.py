from __future__ import unicode_literals

import os
import os.path
import json
import itertools
import random

from django.db import models
from django.conf import settings
#from jsonfield import JSONField
from django_thumbs.db.models import ImageWithThumbsField
from authtools.models import User

from symbolic_math.views import *

class TimestamperMixin(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

class Category(models.Model):
    name = models.CharField(max_length=1000)
    parent = models.ForeignKey('self', null=True, blank=True, related_name="children")
    description = models.TextField(null=True, blank=True)
    image = ImageWithThumbsField(null=True, blank=True, sizes=((125,125),(200,200),(300,300)))

    def __unicode__(self):
        return self.name

class JSLibrary(models.Model):
    name = models.CharField(max_length=100, blank=False, null=False)
    scriptPath = models.CharField(max_length=200, blank=False, null=False)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name_plural = "JS libraries"


class ZeroPlayerGame(TimestamperMixin, models.Model):
    parent = models.ForeignKey('self', null=True, blank=True, related_name="children")
    category = models.ForeignKey(Category)
    owner = models.ForeignKey(User)
    title = models.CharField(max_length=500)
    description = models.TextField(blank=True)
    scriptType = models.CharField(max_length=100, null=True, blank=False)
    source = models.TextField(blank=True)
    seedStructure = models.TextField(blank=True)
    extraIncludes = models.ManyToManyField('JSLibrary', null=True, blank=True)
    mainImage = models.CharField(null=True, blank=True, max_length=255)

    def __unicode__(self):
        return "\"%s\", by %s" % (self.title, self.owner.name)

    def instantiate(self, request, seed=None):
        """
        does not need to be server-side anymore
        """
        print '-----------------'
        
        seedDict = json.loads(self.seedStructure)  
        
        # tidy seedStruct first 
        for k,v in seedDict.iteritems():     
            
            if 'default' not in v:
                seedDict['default'] = ''
            if 'type' not in v:
                seedDict[k]['type'] = 'string'

        # define seed from default
        if seed is None:
            seed = { k: {
                        'type':v['type'],
                        'value':v['default']
                    } for k,v in seedDict.iteritems() }
        
        for k,v in seed.iteritems():     

            if v['type'] == 'math':
                expr = SymbolicExpression(v['value'])
                sym = expr.latex(raw=True)
                v.update(sym)

        if request.user is None:
            user = request.user
        else:
            user = self.owner
            inst = GameInstance(
                game=self,
                instantiator=user,
                seed=json.dumps(seed),
            )

        inst.save()
        return inst

    @property
    def chooseImageSet(order=4):
        images = map(lambda obj: obj.image.name.replace("./", ""), list(itertools.chain(
                    *map(lambda l: l.all(),
                        [instance.images for instance in self.instances.all()]))
                    )
                )
        random.shuffle(images)
        return images[:order]



class GameInstance(TimestamperMixin, models.Model):
    game = models.ForeignKey(ZeroPlayerGame, related_name='instances')
    instantiator = models.ForeignKey(User)
    seed = models.TextField()
    #source = models.TextField()
    #pagecache = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.game.title, self.game.owner.name)

    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


class GameInstanceSnapshot(TimestamperMixin, models.Model):
    instance = models.ForeignKey(GameInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)

    def __unicode__(self):
        return self.instance.game.title + ", " + str(self.created)

    def getFilename(self):
        return self.image.name or None


class SavedFunction(TimestamperMixin, models.Model):
    owner = models.ForeignKey(User, related_name='savedFunctions')
    title = models.CharField(max_length=255, null=True, blank=True)
    source = models.TextField(null=False, blank=False)

    def __unicode__(self):
        return self.title + ": " + self.source[:50] + "..."
