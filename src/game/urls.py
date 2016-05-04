from __future__ import unicode_literals
from django.conf.urls import include, url
from authtools.models import User
from rest_framework import routers, serializers, viewsets
from rest_framework.urlpatterns import format_suffix_patterns
from rest_framework.decorators import api_view, permission_classes
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.views.decorators.csrf import csrf_exempt
from .models import *
from .serializers import *
from . import views
from .views import *

from authtools.models import User

# class UserViewSet(viewsets.ModelViewSet):
#     serializer_class = UserSerializer
#     queryset = User.objects.all()

# @permission_classes((AllowAny, ))
# class CategoryViewSet(viewsets.ModelViewSet):
#     serializer_class = CategorySerializer
#     queryset = Category.objects.all()

#     class Meta:
#         ordering = ['-popularity']


# @permission_classes((AllowAny, ))
# class CategoryAppsViewSet(viewsets.ModelViewSet):
#     serializer_class = CategoryAppsSerializer
#     queryset = Category.objects.all()

#     class Meta:
#         ordering = ['-popularity']

# @permission_classes((AllowAny, ))
# class AppViewSet(viewsets.ModelViewSet):
#     serializer_class = AppSerializer
#     queryset = ZeroPlayerGame.objects.all()

# @permission_classes((AllowAny, ))
# class InstanceViewSet(viewsets.ModelViewSet):
#     serializer_class = InstanceSerializer
#     queryset = GameInstance.objects.all()

#     class Meta:
#         ordering = ['-popularity']

# @permission_classes((AllowAny, ))
# class SnapshotViewSet(viewsets.ModelViewSet):
#     serializer_class = SnapshotSerializer
#     queryset = GameInstanceSnapshot.objects.all()

# @permission_classes((AllowAny, ))
# class CodeModuleViewSet(viewsets.ModelViewSet):
#     queryset = CodeModule.objects.all()
#     serializer_class = CodeModuleSerializer

# @permission_classes((AllowAny, ))
# class AppView(viewsets.ModelViewSet):
#     queryset = ZeroPlayerGame.objects.all()
#     serializer_class = AppSerializer

# @permission_classes((AllowAny, ))
# class AppMinimalViewSet(viewsets.ModelViewSet):
#     queryset = ZeroPlayerGame.objects.all()
#     serializer_class = AppSerializerNoInstances

# @permission_classes((AllowAny, ))
# class InstanceAppViewSet(viewsets.ModelViewSet):
#     qeueryset = ZeroPlayerGame.objects.all()

router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'categories-with-apps', CategoryAppsViewSet)
router.register(r'apps', AppViewSet)
router.register(r'apps-minimal', AppMinimalViewSet)
router.register(r'instances', InstanceViewSet)
#router.register(r'instances-ordered', OrderedInstancesViewSet)
router.register(r'snapshots', SnapshotViewSet)
router.register(r'code_modules', CodeModuleViewSet)


# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    url(r'^$', views.gameindex, name="gameindex"),
    url(r'^api/', include(router.urls)),
    url(r'^test/', views.test, name="gametest"),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^snapshot/$', views.snapshot, name="snapshot-list"),
    url(r'^save_gif/$', views.saveGIF, name="saveGIF"),
    url(r'^instances-ordered/(?P<id>[0-9]+)/$', views.instances_ordered),
    url(r'^instances-ordered-with-key/(?P<id>[0-9]+)/(?P<key>[a-zA-Z\-\_0-9]*)/', views.instances_ordered, name="instances_ordered"),
    url(r'^increment-popularity/(?P<obj>[a-zA-Z]+)/(?P<id>[0-9]+)/$', views.incrementPopularity, name="incrementPopularity"),
    url(r'^app-instantiate/(?P<pk>[0-9]+)/$', views.instantiateGame, name='appInstantiate'),
    url(r'^(?P<static_method>[a-zA-Z\-\_0-9]*)/$', views.call_game_instance_static_method, name="method-handler"),
]

""" 
old API
"""

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
# urlpatterns = [
#     #url(r'^', include(router.urls)),
#     url(r'^$', views.index, name='game-index'),
#     #url(r'^display/(?P<id>[0-9]+)/$', views.display, name='game-display'),
#     url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
#     url(r'^update/(?P<pk>[0-9]+)/$', views.updateGame, name="game-update"),
#     #url(r'^zero-player/$', views.games_list),
#     #url(r'^zero-player/(?P<pk>[0-9]+)/$', views.game_detail),
#     url(r'^zero-player/$', views.GameList.as_view()),
#     url(r'^zero-player/(?P<pk>[0-9]+)/$', views.GameDetail.as_view()),
#     url(r'^zero-player/(?P<pk>[0-9]+)/instantiate/$', views.instantiateGame),
#     url(r'^zero-player/instance/$', views.GameInstanceList.as_view()),
#     url(r'^zero-player/instance/(?P<pk>[0-9]+)/$', views.GameInstanceDetail.as_view()),
#     url(r'^zero-player/snapshot/$', views.snapshotList, name="snapshot-list"),
#     url(r'^zero-player/snapshot/(?P<pk>[0-9]+)/$', views.snapshotDetail),
#
# ]
