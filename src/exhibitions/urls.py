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

class AppViewSet(viewsets.ModelViewSet):
    serializer_class = AppSerializer
    queryset = App.objects.all()

class InstanceViewSet(viewsets.ModelViewSet):
    serializer_class = InstanceSerializer
    queryset = AppInstance.objects.all()

class SnapshotViewSet(viewsets.ModelViewSet):
    serializer_class = SnapshotSerializer
    queryset = Snapshot.objects.all()

router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'apps', AppViewSet)
router.register(r'instances', InstanceViewSet)
router.register(r'snapshots', SnapshotViewSet)


# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    url(r'^api/', include(router.urls)),
    url(r'^$', views.home, name="exhibitions-home"),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

]
