from rest_framework import generics, permissions


from .serializers import UserSerializer, AppSerializer, InstanceSerializer
from .models import App, AppInstance, Snapshot, Category, JSLibrary
#from .permissions import PostAuthorCanEditPermission

from authtools.models import User


class UserList(generics.ListCreateAPIView):
    model = User
    serializer_class = UserSerializer
    queryset = User.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]


class UserDetail(generics.RetrieveAPIView):
    model = User
    serializer_class = UserSerializer
    queryset = User.objects.all()


class InstanceMixin(object):
    model = AppInstance
    serializer_class = InstanceSerializer
    queryset = AppInstance.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]

    def pre_save(self, obj):
        """Force owner to current user"""
        obj.instantiator = self.request.user
        return super(InstanceMixin, self).pre_save(obj)

class InstanceList(InstanceMixin, generics.ListCreateAPIView):
    pass

class InstanceDetail(InstanceMixin, generics.RetrieveUpdateDestroyAPIView):
    pass


# class AppMixin(object):
#     model = App
#     serializer_class = AppSerializer
#     queryset = App.objects.all()
#     permission_classes = [
#         permissions.AllowAny
#     ]
#
#     def pre_save(self, obj):
#         """Force owner to current user"""
#         obj.owner = self.request.user
#         return super(AppMixin, self).pre_save(obj)


class AppList(generics.ListCreateAPIView):
    model = App
    serializer_class = AppSerializer
    queryset = App.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]

    def pre_save(self, obj):
        """Force owner to current user"""
        obj.owner = self.request.user
        return super(AppList, self).pre_save(obj)

class AppDetail(generics.RetrieveUpdateDestroyAPIView):
    model = App
    serializer_class = AppSerializer
    permission_classes = [
        permissions.AllowAny
    ]

class UserAppList(generics.ListAPIView):
    model = App
    serializer_class = AppSerializer

    def get_queryset(self):
        queryset = super(UserAppList, self).get_queryset()
        return queryset.filter(owner__exact=self.kwargs.get('owner'))



# class PhotoList(generics.ListCreateAPIView):
#     model = Photo
#     serializer_class = PhotoSerializer
#     permission_classes = [
#         permissions.AllowAny
#     ]

#     def get_queryset(self):
#        return Photo.objects.all()



# class PhotoDetail(generics.RetrieveUpdateDestroyAPIView):
#     model = Photo
#     serializer_class = PhotoSerializer
#     permission_classes = [
#         permissions.AllowAny
#     ]


# class PostPhotoList(generics.ListAPIView):
#     model = Photo
#     serializer_class = PhotoSerializer

#     def get_queryset(self):
#         return Photo.objects.all()
