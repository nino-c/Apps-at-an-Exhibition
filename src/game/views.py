from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http.request import HttpRequest
from django.core.files import File

from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.parsers import JSONParser
from rest_framework import generics, serializers, viewsets



from sets import Set

import base64
import json
import hashlib
import time
import datetime
import os.path
import os
import plsys.settings

from game.models import *
from game.serializers import *
from plsys.settings import MEDIA_URL


def home(request):
    return render(request, "game/index.html")

@csrf_exempt
def instantiateGame(request, pk):
    try:
        game = ZeroPlayerGame.objects.get(pk=pk)
    except ZeroPlayerGame.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        instance = game.instantiate(request)
        serializer = InstanceSerializer(instance)
        return JsonResponse(serializer.data)

    elif request.method == 'POST':
        seed = json.loads(request.body)
        instance = game.instantiate(request, seed)
        serializer = InstanceSerializer(instance)
        return JsonResponse(serializer.data)

@csrf_exempt
def snapshotList(request, format=None):
    if request.method == 'POST':
        # get raw base64-encoded image
        imageBIN = base64.b64decode(request.POST['image'].split(',')[-1])
        imagename = hashlib.sha224(str(time.time())).hexdigest() + ".png"

        # get instance
        instanceid = int(request.POST['instance'])
        instance = GameInstance.objects.get(pk=instanceid)
        print instance

        # write to /tmp
        file = open(os.path.join("/tmp", imagename), 'w')
        file.write(imageBIN)
        file.close()

        # save new snapshot object
        file =  open(os.path.join("/tmp", imagename), 'r')
        snap = GameInstanceSnapshot()
        snap.instance = instance
        snap.time = float(request.POST['time'])
        snap.image.save(imagename, File(file))
        snap.save()
        file.close()

        #return JsonResponse(im.__dict__)

        return JsonResponse({'a':'ok'})


"""
Test and utility functions below
"""

def updateSeedLists(request):
    out = []
    instances = GameInstance.objects.all()
    #instances = instances[:5]
    for instance in instances:
        for sp in instance.seedParams.all():
            sp.delete()
        seed = json.loads(instance.seed)
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
            
            seedkv = SeedKeyVal(key=key, val=value, jsonval=jsonval)
            seedkv.save()

            instance.seedParams.add(seedkv)
            
            out.append(", ".join(map(lambda sp: sp.key+sp.val, instance.seedParams.all())))
        instance.save()

    return HttpResponse("\n".join(out))


def clean_images(request):
    out = []
    imagesInUse = []
    for instance in GameInstance.objects.all():
        for im in instance.images.all():
            imagesInUse.append(im.image.path)
            imagesInUse.append(im.image.thumbnail(125))
            imagesInUse.append(im.image.thumbnail(200))

    inUseNames = Set(map(lambda x: os.path.basename(x), imagesInUse))
    allImages = Set(filter(lambda x: len(x) > 40, os.listdir(plsys.settings.MEDIA_ROOT)))
    toRemove = allImages.difference(inUseNames)

    ims = map(lambda im: '<img src="/media/'+im+'" height="100" width="100" />', inUseNames)
    # for im in toRemove:
    #     os.remove(os.path.join(plsys.settings.MEDIA_ROOT, im))
    return HttpResponse(''.join(ims))

def review_seeds(request):
    out = []
    for instance in GameInstance.objects.all():
        seeddict = json.loads(instance.seed)
        out.append(', '.join(
            map(lambda x: str(x), 
                [instance.game.title, len(seeddict.keys()), instance.seedParams.count()])
            ))
       
        # to check if there are any mismatched seedobjs and seedcols

        # if len(seeddict.keys()) != instance.seedParams.count():
        #     out.append(insntance.id)

    return HttpResponse('<br />'.join(out))


##############################
#                            #
#            API             #
#                            #
##############################


# class GameList(generics.ListCreateAPIView):
#     queryset = ZeroPlayerGame.objects.all()
#     serializer_class = ZeroPlayerGameSerializer
#
# class GameDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = ZeroPlayerGame.objects.all()
#     serializer_class = ZeroPlayerGameSerializer
#
# class GameInstanceList(generics.ListCreateAPIView):
#     queryset = GameInstance.objects.all()
#     serializer_class = GameInstanceSerializer
#
# class GameInstanceDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = GameInstance.objects.all()
#     serializer_class = GameInstanceSerializer

# class SnapshotList(generics.ListCreateAPIView):
#     queryset = GameInstanceSnapshot.objects.all()
#     serializer_class = SnapshotSerializer

# class SnapshotDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = GameInstanceSnapshot.objects.all()
#     serializer_class = SnapshotSerializer


class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()

#@permission_classes((IsAuthenticated, ))
@permission_classes((AllowAny, ))
class CategoryViewSet(viewsets.ModelViewSet):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()


#@permission_classes((IsAuthenticated, ))
@permission_classes((AllowAny, ))
class CategoryAppsViewSet(viewsets.ModelViewSet):
    serializer_class = CategoryAppsSerializer
    queryset = Category.objects.all()

@permission_classes((AllowAny, ))
class AppViewSet(viewsets.ModelViewSet):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = [IsAuthenticated,]
    serializer_class = AppSerializer
    queryset = ZeroPlayerGame.objects.all()

@permission_classes((AllowAny, ))
class InstanceViewSet(viewsets.ModelViewSet):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = [IsAuthenticated,]
    serializer_class = InstanceSerializer
    queryset = GameInstance.objects.all()

@permission_classes((AllowAny, ))
class SnapshotViewSet(viewsets.ModelViewSet):
    serializer_class = SnapshotSerializer
    queryset = GameInstanceSnapshot.objects.all()

#@permission_classes((IsAuthenticated, ))
@permission_classes((AllowAny, ))
class CodeModuleViewSet(viewsets.ModelViewSet):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = (IsAuthenticated,)
    queryset = CodeModule.objects.all()
    serializer_class = CodeModuleSerializer

@permission_classes((AllowAny, ))
class AppView(viewsets.ModelViewSet):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = (IsAuthenticated,)
    queryset = ZeroPlayerGame.objects.all()
    serializer_class = AppSerializer

@permission_classes((AllowAny, ))
class InstanceAppViewSet(viewsets.ModelViewSet):
    qeueryset = ZeroPlayerGame.objects.all()


"""
manually handle REST API below (old)
"""


# @api_view(['GET', 'POST'])
# @permission_classes((AllowAny,))
# @csrf_exempt
# def games_list(request, format=None):
#     """
#     List all apps, or create a new app.
#     """
#     if request.method == 'GET':
#         games = ZeroPlayerGame.objects.all()
#         serializer = ZeroPlayerGameSerializer(games, many=True)
#         return Response(serializer.data)

#     elif request.method == 'POST':
#         data = JSONParser().parse(request)
#         serializer = ZeroPlayerGameSerializer(data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=201)
#         return Response(serializer.errors, status=400)

# @api_view(['GET', 'PUT', 'DELETE'])
# @permission_classes((AllowAny,))
# @csrf_exempt
# def game_detail(request, pk, format=None):
#     """
#     Retrieve, update or delete a code game.
#     """
#     try:
#         game = ZeroPlayerGame.objects.get(pk=pk)
#     except ZeroPlayerGame.DoesNotExist:
#         return HttpResponse(status=404)

#     if request.method == 'GET':
#         serializer = ZeroPlayerGameSerializer(game)
#         return Response(serializer.data)

#     elif request.method == 'PUT':
#         data = JSONParser().parse(request)
#         serializer = ZeroPlayerGameSerializer(game, data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
#         return Response(serializer.errors, status=400)

#     elif request.method == 'DELETE':
#         game.delete()
#         return HttpResponse(status=204)
