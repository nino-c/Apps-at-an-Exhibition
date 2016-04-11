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

    def instantiate(self, request, seed=None):
        """
        does not need to be server-side anymore... which is easier?
        """

        if request.user is None:
            raise Exception("Must be logged in.")

        seedDict = json.loads(self.seedStructure)  
        
        # tidy seedStruct first 
        for k,v in seedDict.iteritems():     
            if 'type' not in v:
                seedDict[k]['type'] = 'string'
            if 'default' not in v:
                if v['type'] == 'number':
                    seedDict['default'] = 0
                else:
                    seedDict['default'] = ''

        # define seed from default
        if seed is None:
            seed = { 
                k: {
                    'type':v['type'],
                    'value':v['default']
                } for k,v in seedDict.iteritems() }
        
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


        # make seed vector
        vector = self.simplify_seed(seed)

        # create dict 
        inst = {
            'game': self,
            'instantiator': self.owner,
            'seed': json.dumps(seed),
            'vector': json.dumps(vector)
        }

        # create the new instance
        instance, isNew = GameInstance.objects.get_or_create(**inst)
        instance.save()

        # deal with case from old seeds without 'value' key
        i=0
        for key, val in seed.iteritems():
            if type(val) == type(dict()) and 'value' in val:
                value = val['value']
                jsonval = json.dumps(val)
            else:
                value = val
                jsonval = json.dumps(val)

            if seedDict[key]['type'] == 'number':
                try:
                    value['value'] = int(value['value'])
                except Exception:
                    pass

            i += 1
            seedkv = SeedKeyVal(key=key, val=value, jsonval=jsonval, ordering=i)
            seedkv.save()
            
            instance.seedParams.add(seedkv)
            
        instance.save()
        return instance

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
    jsonval = models.TextField(null=False, blank=False, default='')
    ordering = models.IntegerField(null=False, blank=False, default=0)

    class Meta:
        ordering = ('ordering',)


class GameInstance(TimestamperMixin, models.Model):

    game = models.ForeignKey(ZeroPlayerGame, related_name='instances')
    instantiator = models.ForeignKey(User)
    seed = models.TextField()
    seedParams = models.ManyToManyField(SeedKeyVal, null=True, blank=True, related_name='params')
    popularity = models.IntegerField(default=1)
    vector = models.CharField(max_length=5000, null=True, blank=False, unique=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.game.title, self.game.owner.name)

    def record_seed_as_cols(self):
        
        for sp in self.seedParams.all():
            sp.delete()

        seed = json.loads(self.seed)

        i=0
        for key, val in seed.iteritems():
            if type(val) == type(dict()) and 'value' in val:
                value = val['value']
                jsonval = json.dumps(val)
            else:
                value = val
                jsonval = json.dumps(val)

            try:
                value = int(value)
            except:
                value = value

            i += 1
            
            seedkv = SeedKeyVal(key=key, val=value, jsonval=jsonval, ordering=i)
            seedkv.save()
            self.seedParams.add(seedkv)


    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


    def __contains__(self, key):
        return key in self.model.__dict__
    
    def __getitem__(self, key):
        return self.model.__dict__[key]



    #######################################################################################
    #############  Static methods
    #############  or "Meta-Views"

    @staticmethod
    def updateSeedLists(request):

        out = []
        instances = GameInstance.objects.all()

        for instance in instances:

            for sp in instance.seedParams.all():
                sp.delete()
            
            seed = json.loads(instance.seed)

            i=0
            for key, val in seed.iteritems():
                if type(val) == type(dict()) and 'value' in val:
                    value = val['value']
                    jsonval = json.dumps(val)
                else:
                    value = val
                    jsonval = json.dumps(val)

                try:
                    value = int(value)
                except:
                    value = value
                
                i += 1
                seedkv = SeedKeyVal(key=key, val=value, jsonval=jsonval, ordering=i)
                seedkv.save()
                instance.seedParams.add(seedkv)
                out.append(", ".join(map(lambda sp: sp.key+sp.val, instance.seedParams.all())))
            
            instance.save()

        return HttpResponse("\n".join(out))

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



class GameInstanceSnapshot(TimestamperMixin, models.Model):
    instance = models.ForeignKey(GameInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)

    def __unicode__(self):
        return self.instance.game.title + ", " + str(self.created)

    def getFilename(self):
        return self.image.name or None


