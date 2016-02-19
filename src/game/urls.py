from __future__ import unicode_literals
from django.conf.urls import include, url
from authtools.models import User
from rest_framework import routers, serializers, viewsets
from rest_framework.urlpatterns import format_suffix_patterns
from .models import *
from .serializers import *
from . import views

class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()

class CategoryViewSet(viewsets.ModelViewSet):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()

class AppViewSet(viewsets.ModelViewSet):
    serializer_class = AppSerializer
    queryset = ZeroPlayerGame.objects.all()

class InstanceViewSet(viewsets.ModelViewSet):
    serializer_class = InstanceSerializer
    queryset = GameInstance.objects.all()

class SnapshotViewSet(viewsets.ModelViewSet):
    serializer_class = SnapshotSerializer
    queryset = GameInstanceSnapshot.objects.all()

router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'apps', AppViewSet)
router.register(r'instances', InstanceViewSet)
router.register(r'snapshots', SnapshotViewSet)


# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    url(r'^$', views.home, name="exhibitions-home"),
    url(r'^api/', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]

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
