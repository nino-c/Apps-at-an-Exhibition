from django.conf.urls import patterns, url
from . import views


urlpatterns = [
	url(r'^$', views.index, name='index'),
	url(r'^iframe/(?P<appname>[a-zA-Z\_\-0-9]*)$', views.iframe, name='iframe'),
    url(r'^category/(?P<id>[0-9]*)$', views.list_category, name='list-category'),
    url(r'^show/(?P<id>[0-9]*)$', views.show_item, name='show-item'),
]