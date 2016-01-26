from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.parsers import JSONParser
from game.models import PlerpingApp
from game.serializers import PlerpingAppSerializer


@api_view(['GET', 'POST'])
@permission_classes((AllowAny,))
@csrf_exempt
def apps_list(request, format=None):
    """
    List all apps, or create a new app.
    """
    if request.method == 'GET':
        games = PlerpingApp.objects.all()
        serializer = PlerpingAppSerializer(games, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = PlerpingAppSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=201)
        return Response(serializer.errors, status=400)

@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes((AllowAny,))
@csrf_exempt
def app_detail(request, pk, format=None):
    """
    Retrieve, update or delete a code plerpingapp.
    """
    try:
        plerpingapp = PlerpingApp.objects.get(pk=pk)
    except PlerpingApp.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = PlerpingAppSerializer(plerpingapp)
        return Response(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = PlerpingAppSerializer(plerpingapp, data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=400)

    elif request.method == 'DELETE':
        plerpingapp.delete()
        return HttpResponse(status=204)