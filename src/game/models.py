from __future__ import unicode_literals

import os
import os.path
import json
import itertools
import random

from authtools.models import User

from django.http import HttpResponse, JsonResponse
from django.db import models
from django.conf import settings
from django_thumbs.db.models import ImageWithThumbsField

#from django.contrib.postgres.fields import JSONField
#from jsonfield import JSONField
#from jsonfield import JSONField

# that daggum jsonfield... come awn, now, really?  so many!
#  ---> CONCLUDE: eventually must go to CouchDB



from plsys.settings import MEDIA_URL, MEDIA_ROOT
from sets import Set

from symbolic_math.views import *

DIALECTS = (
    ('javascript', 'text/javascript'),
    ('coffeescript', 'text/coffeescript'),
    ('paperscript', 'text/paperscript'),
)

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
    popularity = models.IntegerField(default=1)

    def __unicode__(self):
        return self.name


class JSLibrary(models.Model):
    name = models.CharField(max_length=100, blank=False, null=False)
    scriptPath = models.CharField(max_length=200, blank=False, null=False)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name_plural = "JS libraries"

class SavedFunction(TimestamperMixin, models.Model):
    """
    snippet-like, meant for short user functions
    """
    owner = models.ForeignKey(User, related_name='savedFunctions')
    title = models.CharField(max_length=255, null=True, blank=True)
    language = models.CharField(max_length=20, 
        choices=DIALECTS, default="javascript")
    source = models.TextField(null=False, blank=False)

    def __unicode__(self):
        return self.title + ": " + self.source[:50] + "..."

class CodeModule(TimestamperMixin, models.Model):
    """
    for larger system-provided blocks that 
    hould be available to every user
    """
    title = models.CharField(max_length=255, null=True, blank=True)
    language = models.CharField(max_length=20, choices=DIALECTS, default="javascript")
    source = models.TextField(null=False, blank=False)
    

    def __unicode__(self):
        return self.title + ": " + self.source[:50] + "..."    


class ZeroPlayerGame(TimestamperMixin, models.Model):

    parent = models.ForeignKey('self', null=True, blank=True, related_name="children")
    category = models.ForeignKey(Category, related_name="apps")
    owner = models.ForeignKey(User)
    title = models.CharField(max_length=500)
    description = models.TextField(blank=True)
    scriptType = models.CharField(max_length=100, null=True, blank=False)
    source = models.TextField(blank=True)
    seedStructure = models.TextField(blank=True)
    extraIncludes = models.ManyToManyField('JSLibrary', null=True, blank=True)
    mainImage = models.CharField(null=True, blank=True, max_length=255)
    required_modules = models.ManyToManyField(CodeModule, null=True, blank=True)
    popularity = models.IntegerField(default=1)

    def __unicode__(self):
        return "\"%s\", by %s" % (self.title, self.owner.name)

    def simplify_seed(self, seed):
        return { k:v['value'] for k,v in seed.iteritems() }

    @staticmethod
    def simplify_seed(seed):
        return { k:v['value'] for k,v in seed.iteritems() }

    def instantiate(self, request, seed={}):
        """
        Now should be the *only place to handle: 
            - seed creation
            - kv col management
        does not need to be server-side anymore... which is easier?
        """

        if request.user is None:
            raise Exception("Must be logged in.")

        seedDict = json.loads(self.seedStructure)  
        
        # ensure seedDict has `type` and `default` on each value-dict
        for k,v in seedDict.iteritems():     
            if 'type' not in v:
                v['type'] = 'string'
            if 'default' not in v:
                if v['type'] == 'number':
                    v = 0
                else:
                    v = ''
            value = v['value'] if 'value' in v else v['default']
            seed[k] = {'type':v['type'], 'value':value}

        for k,v in seed.iteritems():     
            if v['type'] == 'math':
                expr = SymbolicExpression(v['value'])
                sym = expr.latex(raw=True)
                v.update(sym)
            if v['type'] == 'number':
                try:
                    v['value'] = int(v['value'])
                except Exception:
                    pass
            if 'value' not in v:
                v = {'value':v}

        # make seed vector
        vector = { k:v['value'] for k,v in seed.iteritems() }

        # create dict 
        inst = {
            'game': self,
            'instantiator': self.owner,
            'seed': json.dumps(seed),
        }

        inst2 = {
            'vector': json.dumps(vector)
        }


        # create the new instance
        instance, isNew = GameInstance.objects.get_or_create(vector=json.dumps(vector))
        meta = {}

        if isNew:
            meta['alreadyExists'] = False
            for k,v in inst:
                instance.__setattr__(k,v)
        else:
            meta['alreadyExists'] = True
            return meta, instance

        instance.save()

        for kv in instance.seedParams.all():
            kv.delete()

        # deal with case from old seeds without 'value' key
        #kvs = map(lambda (k,v): SeedKeyVal(key=k, val=v['value'], jsonval=json.dumps(v), ordering=0), seed.iteritems())

        kvs = [ SeedKeyVal(key=k, val=v['value'], jsonval=json.dumps(v), ordering=0) \
            for k,v in seed.iteritems() ]

        for i,kv in enumerate(kvs):
            kv.ordering = i
            kv.save()
            instance.seedParams.add(kv)
            
        instance.save()
        return meta, instance

    @property
    def chooseImageSet(order=4):
        images = map(lambda obj: obj.image.name.replace("./", ""), list(itertools.chain(
                    *map(lambda l: l.all(),
                        [instance.images for instance in self.instances.all()]))
                    )
                )
        random.shuffle(images)
        return images[:order]


class SeedKeyVal(models.Model):

    key = models.CharField(max_length=255, blank=False)
    val = models.CharField(max_length=5000, null=False, blank=False, default='')
    valtype = models.CharField(max_length=25, null=False, blank=False, default='string')
    jsonval = models.TextField(null=False, blank=False, default='')
    ordering = models.IntegerField(null=False, blank=False, default=0)

    class Meta:
        ordering = ('ordering',)




class GameInstance(TimestamperMixin, models.Model):

    game = models.ForeignKey(ZeroPlayerGame, related_name='instances')
    instantiator = models.ForeignKey(User)
    seed = models.TextField()
    seedParams = models.ManyToManyField(SeedKeyVal, null=True, blank=True, related_name='params')
    # seedParams = models.ManyToManyField(SeedKeyVal, null=True, blank=True, \
    #     through="SeedKeyValRelationship")
    popularity = models.IntegerField(default=1)
    vector = models.CharField(max_length=5000, null=True, blank=False, unique=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.game.title, self.game.owner.name)

    def record_seed_as_cols(self):
        
        for kv in self.seedParams.all():
            kv.delete()

        seed = json.loads(self.seed)

        for k,v in seed.iteritems(): 
            if 'value' not in v:
                v = {'value':v}    
            if v['type'] == 'number':
                try:
                    v['value'] = int(v['value'])
                except Exception:
                    pass
            

        # deal with case from old seeds without 'value' key
        kvs = map(lambda (k,v): SeedKeyVal(key=k, val=v['value'], jsonval=json.dumps(v), 
            ordering=0, valtype=v['type']), seed.iteritems())
        for i,kv in enumerate(kvs):
            kv.ordering = i
            kv.save()
            self.seedParams.add(kv)
            
        self.save()

    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


    # def __contains__(self, key):
    #     return key in self.model.__dict__
    
    # def __getitem__(self, key):
    #     print '---key', key
    #     if key in self.model.__dict__:
    #         return self.model.__dict__[key]
    #     else:
    #         raise Exception('no item '+str(key))



    #######################################################################################
    #############  Static methods
    #############  or "Meta-Views"

    @staticmethod
    def record_seeds(request):
        out=[]
        sds = GameInstance.objects.all()
        for instance in sds:
            instance.record_seed_as_cols()
            out.append(str(instance.id))
        return HttpResponse(', '.join(out))


    @staticmethod
    def clean_images(request):
        """
        Removes excess media files (images)
        created to thin down app for Heroku deploy
        """
        out = []
        imagesInUse = []
        for instance in GameInstance.objects.all():
            for im in instance.images.all():
                imagesInUse.append(im.image.path)
                imagesInUse.append(im.image.thumbnail(125))
                imagesInUse.append(im.image.thumbnail(200))

        inUseNames = Set(map(lambda x: os.path.basename(x), imagesInUse))
        allImages = Set(filter(lambda x: len(x) > 40, os.listdir(MEDIA_ROOT)))
        toRemove = allImages.difference(inUseNames)

        ims = map(lambda im: '<img src="/media/'+im+'" height="100" width="100" />', inUseNames)
        # for im in toRemove:
        #     os.remove(os.path.join(plsys.settings.MEDIA_ROOT, im))
        return HttpResponse(''.join(ims))

    @staticmethod
    def enforce_unique_seedparam_cols(request):
        out = []
        for instance in GameInstance.objects.all():
            seeddict = json.loads(instance.seed)
            out.append(', '.join(
                map(lambda x: str(x), 
                    [instance.game.title, len(seeddict.keys()), instance.seedParams.count()])
                ))
           
            # to check if there are any mismatched seedobjs and seedcols

            if len(seeddict.keys()) != instance.seedParams.count():
                out.append(instance.id)

        return JsonResponse(out)

class SeedKeyValRelationship(models.Model):
    instance = models.ForeignKey(GameInstance, on_delete=models.CASCADE)
    keyval = models.ForeignKey(SeedKeyVal, on_delete=models.CASCADE)


class GameInstanceSnapshot(TimestamperMixin, models.Model):
    instance = models.ForeignKey(GameInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)

    def __unicode__(self):
        return self.instance.game.title + ", " + str(self.created)

    def getFilename(self):
        return self.image.name or None


