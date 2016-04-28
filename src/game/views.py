from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, Http404
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

from plsys.settings import *

from game.models import *
from game.serializers import *

def getAngularFiles():
    angular_dirs = ['modules', 'services', 'directives', 'controllers', 'filters']
    angular_appdir_site = '/static/AaaE/js'
    angular_appdir = os.path.join(STATIC_ROOT, "AaaE/js")
    angular_includes = reduce(
        lambda a,b: a+b, map( 
            lambda dir: sorted(
                filter(
                    lambda file: not file.startswith('_'), 
                        map(lambda f: os.path.join("AaaE/js", dir, f), os.listdir(os.path.join(angular_appdir, dir)))
                    )), angular_dirs)
        )
    return angular_includes

def gameindex(request):
    return render(request, "angular-index.html", 
        {'angular_includes': getAngularFiles(), 'isAngularApp': True})

def incrementPopularity(request, obj, id):
    if obj == 'category':
        item = Category.objects.get(pk=id)
    elif obj == 'app':
        item = ZeroPlayerGame.objects.get(pk=id)
    
    if item:
        item.popularity = item.popularity + 1
        item.save()
        return HttpResponse(item.popularity)


@csrf_exempt
def instantiateGame(request, pk):

    try:
        game = ZeroPlayerGame.objects.get(pk=pk)
    except ZeroPlayerGame.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        meta, instance = game.instantiate(request)
        serializer = InstanceSerializer(instance)
        sdata = dict(serializer.data)
        sdata.update(**meta)
        return JsonResponse(sdata)

    elif request.method == 'POST':
        seed = json.loads(request.body)
        meta, instance = game.instantiate(request, seed)
        serializer = InstanceSerializer(instance)
        sdata = dict(serializer.data)
        sdata.update(**meta)
        return JsonResponse(sdata)

@csrf_exempt
def snapshot(request, format=None):
    if request.method == 'POST':

        # get raw base64-encoded image
        imageBIN = base64.b64decode(request.POST['image'].split(',')[-1])
        imagename = hashlib.sha224(str(time.time())).hexdigest() + ".png"

        # get instance
        instanceid = int(request.POST['instance'])
        instance = GameInstance.objects.get(pk=instanceid)

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

        return JsonResponse({'a':'ok'})

@api_view(['GET'])
@permission_classes((AllowAny, ))
def instances_ordered(request, id, key=None):
    app = ZeroPlayerGame.objects.get(pk=id)
    seedstruct = json.loads(app.seedStructure)
    
    key = None
    searchtype = 'int_val'

    index_keys = [(k,v) for k,v in seedstruct.iteritems() if 'index' in v and v['index'] == True]
    if len(index_keys) == 0:
        number_keys = [(k,v) for k,v in seedstruct.iteritems() if v['type'] == 'number']
        if len(number_keys) > 0:
            key = number_keys[0][0]
        else:
            key = seedstruct.keys()[0]
            searchtype = 'val'
    else:
        key = index_keys[0][0]
        if seedstruct[key]['type'] != 'number':
            searchtype = 'val'
    
    vectorparam_set = SeedVectorParam.objects.filter(app=app, 
        key=key).order_by(searchtype).select_related('instance')
    instances = [element.instance for element in vectorparam_set]
    serializer = OrderedInstanceSerializer(instances, many=True)
    return Response(serializer.data)


"""
Test and utility functions below
"""

def call_game_instance_static_method(request, static_method):
    """
    generic function to call staticmethods on GameInstance
    """
    if hasattr(GameInstance, static_method):
        method = getattr(GameInstance, static_method)
        if callable(method):
            return method.__call__(request)
    
    raise Exception("method does not exist")



##############################
#                            #
#          REST views        #
#                            #
##############################


class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()

@permission_classes((AllowAny, ))
class CategoryViewSet(viewsets.ModelViewSet):
    serializer_class = CategorySerializer
    queryset = Category.objects.filter(enabled=True).order_by('-popularity')

@permission_classes((AllowAny, ))
class CategoryAppsViewSet(viewsets.ModelViewSet):
    serializer_class = CategoryAppsSerializer
    queryset = Category.objects.filter(enabled=True).all()

@permission_classes((AllowAny, ))
class AppViewSet(viewsets.ModelViewSet):
    serializer_class = AppSerializer
    queryset = ZeroPlayerGame.objects.all()

# @permission_classes((AllowAny, ))
# class OrderedInstancesViewSet(viewsets.ModelViewSet):
#     serializer_class = OrderedInstanceSerializer
#     queryset = ZeroPlayerGame.objects.all()


@permission_classes((AllowAny, ))       
class AppMinimalViewSet(viewsets.ModelViewSet):
    queryset = ZeroPlayerGame.objects.all()
    serializer_class = AppSerializerNoInstances

@permission_classes((AllowAny, ))
class InstanceViewSet(viewsets.ModelViewSet):
    serializer_class = InstanceSerializer
    queryset = GameInstance.objects.all()

@permission_classes((AllowAny, ))
class InstanceViewSet(viewsets.ModelViewSet):
    serializer_class = InstanceSerializer
    queryset = GameInstance.objects.all()

# @permission_classes((AllowAny, ))
# class InstanceMinimalViewSet(viewsets.ModelViewSet):
#     serializer_class = InstanceSerializerMinimal
#     queryset = GameInstance.objects.all()


@permission_classes((AllowAny, ))
class SnapshotViewSet(viewsets.ModelViewSet):
    serializer_class = SnapshotSerializer
    queryset = GameInstanceSnapshot.objects.all()

@permission_classes((AllowAny, ))
class CodeModuleViewSet(viewsets.ModelViewSet):
    queryset = CodeModule.objects.all()
    serializer_class = CodeModuleSerializer

# @permission_classes((AllowAny, ))
# class AppView(viewsets.ModelViewSet):
#     queryset = ZeroPlayerGame.objects.prefetch_related('seedParams__valtype')



@permission_classes((AllowAny, ))
class InstanceAppViewSet(viewsets.ModelViewSet):
    qeueryset = ZeroPlayerGame.objects.all()



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

"""
manually handle REST API below (old)
"""

# @api_view(['GET', 'POST'])
# @permission_classes((AllowAny,))
# def InstanceService(request, format=None):
#     """
#     List all apps, or create a new app.
#     """
#     if request.method == 'GET':
#         games = GameInstance.objects.all()
#         serializer = GameInstanceSerializer(games, many=True)
#         return Response(serializer.data)

#     elif request.method == 'POST':
#         data = JSONParser().parse(request)
#         serializer = GameInstanceSerializer(data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=201)
#         return Response(serializer.errors, status=400)

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
