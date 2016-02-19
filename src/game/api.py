from __future__ import unicode_literals
from rest_framework import generics, permissions


from .serializers import *
from .models import *
#from .permissions import PostAuthorCanEditPermission

from authtools.models import User


class UserList(generics.ListCreateAPIView):
    model = User
    serializer_class = UserSerializer
    queryset = User.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]

class CategoryList(generics.ListCreateAPIView):
    model = Category
    serializer_class = CategorySerializer
    queryset = Category.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]

class UserDetail(generics.RetrieveAPIView):
    model = User
    serializer_class = UserSerializer
    queryset = User.objects.all()


class InstanceMixin(object):
    model = GameInstance
    serializer_class = InstanceSerializer
    queryset = GameInstance.objects.all()
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
    model = ZeroPlayerGame
    serializer_class = ZeroPlayerGameSerializer
    queryset = ZeroPlayerGame.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]

    def pre_save(self, obj):
        """Force owner to current user"""
        obj.owner = self.request.user
        return super(AppList, self).pre_save(obj)

class AppDetail(generics.RetrieveUpdateDestroyAPIView):
    model = ZeroPlayerGame
    serializer_class = AppSerializer
    permission_classes = [
        permissions.AllowAny
    ]

class UserAppList(generics.ListAPIView):
    model = ZeroPlayerGame
    serializer_class = ZeroPlayerGameSerializer

    def get_queryset(self):
        queryset = super(UserAppList, self).get_queryset()
        return queryset.filter(owner__exact=self.kwargs.get('owner'))

class SnapshotList(generics.ListCreateAPIView):
    queryset = GameInstanceSnapshot.objects.all()
    serializer_class = SnapshotSerializer

class SnapshotDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = GameInstanceSnapshot.objects.all()
    serializer_class = SnapshotSerializer

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
