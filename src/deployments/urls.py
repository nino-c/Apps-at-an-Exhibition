from django.conf.urls import patterns, url
from . import views


urlpatterns = [
    url(r'^(?P<requestfile>[a-zA-Z0-9\-\_]+)$', views.index, name='getfile'),

]