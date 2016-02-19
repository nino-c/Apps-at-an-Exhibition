from django.conf.urls import patterns, include, url
from authtools.models import User
from rest_framework import routers, serializers, viewsets
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

# # Serializers define the API representation.
# class UserSerializer(serializers.HyperlinkedModelSerializer):
#     class Meta:
#         model = User
#         fields = ('email', 'is_staff')

# # ViewSets define the view behavior.
# class UserViewSet(viewsets.ModelViewSet):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# # Routers provide an easy way of automatically determining the URL conf.
# router = routers.DefaultRouter()
# router.register(r'users', UserViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    #url(r'^', include(router.urls)),
    url(r'^$', views.index, name='game-index'),
    #url(r'^display/(?P<id>[0-9]+)/$', views.display, name='game-display'),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^update/(?P<pk>[0-9]+)/$', views.updateGame, name="game-update"),
    #url(r'^zero-player/$', views.games_list),
    #url(r'^zero-player/(?P<pk>[0-9]+)/$', views.game_detail),
    url(r'^zero-player/$', views.GameList.as_view()),
    url(r'^zero-player/(?P<pk>[0-9]+)/$', views.GameDetail.as_view()),
    url(r'^zero-player/(?P<pk>[0-9]+)/instantiate/$', views.instantiateGame),
    url(r'^zero-player/instance/$', views.AppInstanceList.as_view()),
    url(r'^zero-player/instance/(?P<pk>[0-9]+)/$', views.AppInstanceDetail.as_view()),
    url(r'^zero-player/snapshot/$', views.snapshotList, name="snapshot-list"),
    url(r'^zero-player/snapshot/(?P<pk>[0-9]+)/$', views.snapshotDetail),
    
]

urlpatterns = format_suffix_patterns(urlpatterns)