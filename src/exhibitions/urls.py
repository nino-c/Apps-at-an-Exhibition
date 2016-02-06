from django.conf.urls import patterns, url, include

from .api import AppList, AppDetail, AppInstanceList
# from .api import PostList, PostDetail, UserPostList
# from .api import PhotoList, PhotoDetail, PostPhotoList

# user_urls = [,
#     url(r'^/(?P<id>[0-9]*)/apps$', UserPostList.as_view(), name='userpost-list'),
#     url(r'^/(?P<id>[0-9]*)$', UserDetail.as_view(), name='user-detail'),
#     url(r'^$', UserList.as_view(), name='user-list')
# ]

app_urls = [
    url(r'^(?P<id>\d+)/instances$', AppInstanceList.as_view(), name='app-instance-list'),
    url(r'^(?P<id>\d+)$', AppDetail.as_view(), name='app-detail'),
    url(r'^$', AppList.as_view(), name='app-list')    
]

# post_urls = patterns('',
#     url(r'^/(?P<pk>\d+)/photos$', PostPhotoList.as_view(), name='postphoto-list'),
#     url(r'^/(?P<pk>\d+)$', PostDetail.as_view(), name='post-detail'),
#     url(r'^$', PostList.as_view(), name='post-list')
# )

# photo_urls = patterns('',
#     url(r'^/(?P<pk>\d+)$', PhotoDetail.as_view(), name='photo-detail'),
#     url(r'^$', PhotoList.as_view(), name='photo-list')
# )

urlpatterns = [
    #url(r'^users', include(user_urls)),
    url(r'^apps/$', include(app_urls)),
    #url(r'^photos', include(photo_urls)),
]