from django.conf.urls import patterns, url, include
from rest_framework import routers, serializers, viewsets
#from rest_framework.urlpatterns import format_suffix_patterns
from .api import AppList, AppDetail, UserList, UserDetail, \
    InstanceList, InstanceDetail, UserAppList



user_urls = [
    #url(r'^(?P<id>\d+)/instances$', AppInstanceList.as_view(), name='app-instance-list'),
    url(r'^$', UserList.as_view()),
    url(r'^(?P<pk>[0-9]+)/$', UserDetail.as_view()),
    url(r'^(?P<pk>[0-9]+)/apps/$', UserAppList.as_view(), "user-app-list"),
]


app_urls = [
    #url(r'^(?P<id>\d+)/instances$', AppInstanceList.as_view(), name='app-instance-list'),
    url(r'^$', AppList.as_view(), name="app-list"),
    url(r'^(?P<pk>[0-9]+)/$', AppDetail.as_view(), name="app-detail"),
    url(r'^instances/$', InstanceList.as_view(), name="app-instance-list"),
    url(r'^instances/(?P<pk>[0-9]+)/$', InstanceDetail.as_view(), name="app-instance-detail"),
]

urlpatterns = [
    url(r'^apps/', include(app_urls)),
    url(r'^users/', include(user_urls)),
]

#urlpatterns = format_suffix_patterns(urlpatterns)

# post_urls = patterns('',
#     url(r'^/(?P<pk>\d+)/photos$', PostPhotoList.as_view(), name='postphoto-list'),
#     url(r'^/(?P<pk>\d+)$', PostDetail.as_view(), name='post-detail'),
#     url(r'^$', PostList.as_view(), name='post-list')
# )

# photo_urls = patterns('',
#     url(r'^/(?P<pk>\d+)$', PhotoDetail.as_view(), name='photo-detail'),
#     url(r'^$', PhotoList.as_view(), name='photo-list')
# )


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
    
# ]

