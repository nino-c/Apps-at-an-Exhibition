from __future__ import unicode_literals

import os
import os.path
import json
import itertools
import random
import copy

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

# mr codeswitcher is a flip-of-the-lip syntactic dick

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
    enabled = models.BooleanField(null=False, blank=False, default=True)
    popularity = models.IntegerField(default=1)

    def __unicode__(self):
        return self.name

    def get_total_popularity(self):
        return sum(map(lambda app: app.popularity, self.apps.all()))

    def get_avg_popularity(self):
        return sum(map(lambda app: app.popularity, self.apps.all())) / self.apps.count()


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

    def getDefaultSeed(self):
        seedDict = json.loads(self.seedStructure)  
        seed = {}
        # ensure seedDict has `type` and `default` on each value-dict
        for k,v in seedDict.iteritems():     
            if 'type' not in v:
                v['type'] = 'string'
            

            value = v['value'] if 'value' in v else v['default']
            seed[k] = {'type':v['type'], 'value':value}

        return seed

    def getSeedVector(self, seed={}):
        seedDict = json.loads(self.seedStructure)  
        
        # ensure seedDict has `type` and `default` on each value-dict
        for k,v in seedDict.iteritems():     
            if 'type' not in v:
                v['type'] = 'string'
            if 'default' not in v:
                if v['type'] == 'number':
                    v['value'] = 0
                else:
                    v['value'] = ''

            value = seed[k]['value'] if 'value' in seed[k] else v['default']
            seed[k] = {'type':v['type'], 'value':value}

        vector = copy.deepcopy(seed) #{ k:v for k,v in seed.iteritems() }
        for k,v in vector.iteritems():   
            if type(v) is not dict:
                v = {'value':v, 'type':'string'}  

            if v['type'] == 'math':
                _val = v['value']
                expr = SymbolicExpression(_val)
                sym = expr.latex(raw=True)
                v.update(sym)
            elif v['type'] == 'number':
                try:
                    v['value'] = int(v['value'])
                except Exception:
                    pass
            elif v['type'] == 'color':
                try:
                    v['value'] = int(str(v['value']).replace('#', ''), 16)
                except Exception:
                    raise Exception

        # print "==== getSeedVector ===="
        # print vector
        
        return vector

    def instantiate(self, request, seed={}):
        """
        Now should be the *only place to handle: 
            - seed creation
            - kv col management
        does not need to be server-side anymore... which is easier?
        """
        if request.user is None:
            raise Exception("Must be logged in.")

        if seed == {}:
            print '--default seed'
            seed = self.getDefaultSeed()
            print seed


        vector = self.getSeedVector(seed)
        print '--seed', seed
        print '--vector', vector
        # create dict 
        inst = {
            'game': self,
            'instantiator': self.owner,
            'seed': json.dumps(seed),
            'vector': json.dumps(vector)
        }
        #print '---inst', inst
        
        # create the new instance
        #print "searching gi's for vector: " + inst['vector']
        isNew = False
        try:
            instance = GameInstance.objects.get(vector=inst['vector'])
        except GameInstance.DoesNotExist:
            instance = GameInstance.objects.create(**inst)
            isNew = True

        meta = {}

        if isNew:
            meta['alreadyExists'] = False
        else:
            meta['alreadyExists'] = True
            return meta, instance

        instance.parseVectorParams()
        instance.save()

        return meta, instance

    def getImageSet(self, order=20, shuffled=False):
        images = map(lambda obj: obj.image.name.replace("./", ""), list(itertools.chain(
                    *map(lambda l: l.all(),
                        [instance.images for instance in self.instances.all()]))
                    )
                )
        if shuffled:
            random.shuffle(images)
        return images[:order]



class GameInstance(TimestamperMixin, models.Model):

    game = models.ForeignKey(ZeroPlayerGame, related_name='instances')
    instantiator = models.ForeignKey(User)
    seed = models.TextField()
    popularity = models.IntegerField(default=1)
    vector = models.CharField(max_length=5000, null=True, blank=False, unique=True)

    def __unicode__(self):
        return "%s's instance of \"%s\", by %s" % (self.instantiator.name, self.game.title, self.game.owner.name)

    # def save(self, *args, **kwargs):
    #     print '--save instance'
    #     kvs, kdict = self.parseVectorParams()
    #     print kdict
    #     print '--inserted vector-string', json.dumps(kdict)
    #     kwargs.update({'vector',json.dumps(kdict)})
    #     print instance
    #     super(GameInstance).save(*args, **kwargs)

    def getSeedVector(self):
        seed = json.loads(self.seed)
        return self.game.getSeedVector(seed)

    def parseVectorParams(self):
        print "============="
        print 'parseVectorParams'
        seed = json.loads(self.seed)
        seedDict = json.loads(self.game.seedStructure)
        for kv in self.vectorparams.all():
            kv.delete()

        kvs = []
        kdict = {}
        for k,v in seed.iteritems():

            if 'type' not in seedDict[k]:
                seedDict[k]['type'] = 'string'

            paramdict = {
                'key':k, 
                'instance':self,
                'app':self.game,
                'val':v['value'], 
                'jsonval':json.dumps(v), 
                'valtype':seedDict[k]['type'],
                'ordering':0
            }

            if seedDict[k]['type'] == 'number':
                paramdict['int_val'] = int(paramdict['val'])
            elif seedDict[k]['type'] == 'color':
                paramdict['int_val'] = int(paramdict['val'].replace('#',''), 16)
            

            kvs.append(SeedVectorParam(**paramdict))
            kdict[k] = paramdict

        for i,kv in enumerate(kvs):
            kv.ordering = i
            kv.save()
            self.vectorparams.add(kv)

        self.save()
        print '---parseVectorParams', kdict
        return kvs, kdict

    @staticmethod
    def index_seed_vectors(request):
        out = []
        not_unique = []
        for inst in GameInstance.objects.all():
            try:
                kvs = inst.index_seed_vector()
            except Exception:
                not_unique.append(inst.id)
                #print 'UNIQ', ', '.join(map(str, not_unique))
                #raise Exception("Dooplikate vektor")
                continue

            out.append(kvs)

        out.append(', '.join(not_unique))        
        return JsonResponse(out)

    def index_seed_vector(self):
        seed = json.loads(self.seed)
        #kvs = self.parseVectorParams()
        self.vector = json.dumps(self.game.getSeedVector(seed))
        print "--- self.vector", self.vector
        self.save()
        return kvs

    def getImages(self):
        if self.images.count() > 0:
            return [im.image.name.replace("./","") for im in self.images.all()]
        else:
            return []


    #######################
    ##  Static methods
    ##  or "Meta-Views"

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
        #print allImages, inUseNames
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



class SeedVectorParam(models.Model):

    instance = models.ForeignKey(GameInstance, related_name='vectorparams')
    app = models.ForeignKey(ZeroPlayerGame, related_name='instance_vectorparams')
    key = models.CharField(max_length=255, blank=False)
    val = models.CharField(max_length=5000, null=True, blank=True, default='')
    int_val = models.IntegerField(null=True, blank=True)
    valtype = models.CharField(max_length=25, null=False, blank=False, default='string')
    jsonval = models.TextField(null=False, blank=False, default='')
    ordering = models.IntegerField(null=False, blank=False, default=0)

    class Meta:
        ordering = ('ordering',)


# class SeedKeyValRelationship(models.Model):
#     instance = models.ForeignKey(GameInstance, on_delete=models.CASCADE)
#     keyval = models.ForeignKey(SeedKeyVal, on_delete=models.CASCADE)

# class SeedKeyVal(models.Model):

#     key = models.CharField(max_length=255, blank=False)
#     val = models.CharField(max_length=5000, null=False, blank=False, default='')
#     valtype = models.CharField(max_length=25, null=False, blank=False, default='string')
#     jsonval = models.TextField(null=False, blank=False, default='')
#     ordering = models.IntegerField(null=False, blank=False, default=0)

#     class Meta:
#         ordering = ('ordering',)

    
class GameInstanceSnapshot(TimestamperMixin, models.Model):
    instance = models.ForeignKey(GameInstance, related_name='images')
    image = ImageWithThumbsField(sizes=((125,125),(200,200)))
    time = models.FloatField(default=0, blank=False)

    def __unicode__(self):
        return self.instance.game.title + ", " + str(self.created)

    def getFilename(self):
        return self.image.name or None


