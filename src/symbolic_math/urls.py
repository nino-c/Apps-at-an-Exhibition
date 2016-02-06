from django.conf.urls import patterns, include, url
#from authtools.models import User
from . import views


###  !!!!!!!!!!!!! look at commented code below, 
###  !!!!!!!!!!!!!   -need to investigate this approach more

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
    url(r'^$', views.index, name="symbolic-math-home"),
    url(r'^(?P<funcname>[a-zA-Z]+)/$', views.exec_function, name='exec-function'),
    #url(r'^display/(?P<id>[0-9]+)/$', views.display, name='game-display'),
  
    
]
