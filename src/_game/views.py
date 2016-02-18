from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.parsers import JSONParser

from rest_framework import generics
from game.models import *
from game.serializers import *
from plsys.settings.development import MEDIA_URL

import base64
import json
from django.core.files import File
import hashlib
import time
import datetime


def index(request):
    return render(request, "game/index.html")

def instantiateGame(request, pk):
    try:
        game = App.objects.get(pk=pk)
    except App.DoesNotExist:
        return HttpResponse(status=404)

    instance = game.instantiate(request)
    serializer = AppInstanceSerializer(instance)
    return JsonResponse(serializer.data)

@csrf_exempt
def updateGame(request, pk):
    try:
        game = App.objects.get(pk=pk)
    except App.DoesNotExist:
        return HttpResponse(status=404)
    #print dir(game)
    #print game.__dict__
    print "---------------"

    if request.method == 'POST':
        #print request.POST['source'][:100]
        print str(type(game))
        print str(type(request.POST.get('source')))
        game.source = request.POST.get('source')
        print request.POST['source'][:10]
        print '========================'
        print game.source[:10]
        game.seedStructure = request.POST['seedStructure']
        game.save()

        

        game2 = App.objects.get(pk=pk)
        #print game2.__dict__
        
        gamedict = game.__dict__
        serializer = AppSerializer(game)
        return JsonResponse(serializer.data)



##############################
#                            #
#            API             #
#                            #
##############################


class GameList(generics.ListCreateAPIView):
    queryset = App.objects.all()
    serializer_class = AppSerializer

class GameDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = App.objects.all()
    serializer_class = AppSerializer

class AppInstanceList(generics.ListCreateAPIView):
    queryset = AppInstance.objects.all()
    serializer_class = AppInstanceSerializer

class AppInstanceDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AppInstance.objects.all()
    serializer_class = AppInstanceSerializer

# class SnapshotList(generics.ListCreateAPIView):
#     queryset = Snapshot.objects.all()
#     serializer_class = SnapshotSerializer

# class SnapshotDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = Snapshot.objects.all()
#     serializer_class = SnapshotSerializer

# @api_view(['GET', 'POST'])
# @permission_classes((AllowAny,))
@csrf_exempt
def snapshotList(request, format=None):
    if request.method == 'POST':
        # get raw base64-encoded image
        imageBIN = base64.b64decode(request.POST['image'].split(',')[-1])
        imagename = hashlib.sha224(str(time.time())).hexdigest() + ".png"

        # get instance
        instanceid = int(request.POST['instance'])
        instance = AppInstance.objects.get(pk=instanceid)
        print instance

        # write to /tmp
        file = open(os.path.join("/tmp", imagename), 'w')
        file.write(imageBIN)
        file.close()

        # save new snapshot object
        file =  open(os.path.join("/tmp", imagename), 'r')
        snap = Snapshot()
        snap.instance = instance
        snap.time = float(request.POST['time'])
        snap.image.save(imagename, File(file))
        snap.save()
        file.close()

        #return JsonResponse(im.__dict__)

        return JsonResponse({'a':'ok'})

# instance = models.ForeignKey(AppInstance)
#     image = ImageWithThumbsField(sizes=((125,125),(200,200)))
#     time = models.FloatField(default=0, blank=False)
#     gallery = models.ForeignKey(AppInstance, null=True, related_name='images')
#     timestamp = models.DateTimeField(auto_now_ad

def snapshotDetail(request, format=None):
    pass

# @api_view(['GET', 'POST'])
# @permission_classes((AllowAny,))
# @csrf_exempt
# def games_list(request, format=None):
#     """
#     List all apps, or create a new app.
#     """
#     if request.method == 'GET':
#         games = App.objects.all()
#         serializer = AppSerializer(games, many=True)
#         return Response(serializer.data)

#     elif request.method == 'POST':
#         data = JSONParser().parse(request)
#         serializer = AppSerializer(data=data)
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
#         game = App.objects.get(pk=pk)
#     except App.DoesNotExist:
#         return HttpResponse(status=404)

#     if request.method == 'GET':
#         serializer = AppSerializer(game)
#         return Response(serializer.data)

#     elif request.method == 'PUT':
#         data = JSONParser().parse(request)
#         serializer = AppSerializer(game, data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
#         return Response(serializer.errors, status=400)

#     elif request.method == 'DELETE':
#         game.delete()
#         return HttpResponse(status=204)