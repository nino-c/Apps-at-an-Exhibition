from rest_framework import generics, permissions


from .serializers import serial_User, serial_App
from .models import App, AppInstance, Snapshot
#from .permissions import PostAuthorCanEditPermission

from authtools.models import User


class AppList(generics.ListAPIView):
    model = App
    serializer_class = serial_App
    queryset = App.objects.all()
    permission_classes = [
        permissions.AllowAny
    ]


class AppDetail(generics.RetrieveUpdateDestroyAPIView):
    model = App
    serializer_class = serial_App
    permission_classes = [
        permissions.AllowAny
    ]

class AppInstanceList(generics.RetrieveUpdateDestroyAPIView):
    #model = AppInstance
    #serializer_class = 
    pass


class UserList(generics.ListAPIView):
    model = User
    serializer_class = serial_User
    permission_classes = [
        permissions.AllowAny
    ]

    # def get_queryset(self):
    #     return Post.objects.all()


class UserDetail(generics.RetrieveAPIView):
    model = User
    serializer_class = serial_User
    #lookup_field = 'username'


# class PostMixin(object):
#     model = Post
#     serializer_class = PostSerializer
#     permission_classes = [
#         PostAuthorCanEditPermission
#     ]

#     def pre_save(self, obj):
#         """Force author to the current user on save"""
#         obj.author = self.request.user
#         return super(PostMixin, self).pre_save(obj)


# class PostList(PostMixin, generics.ListCreateAPIView):
#     def get_queryset(self):
#         return Post.objects.all()


# class PostDetail(PostMixin, generics.RetrieveUpdateDestroyAPIView):
#     pass


# class UserPostList(generics.ListAPIView):
#     model = Post
#     serializer_class = PostSerializer

#     def get_queryset(self):
#         queryset = super(UserPostList, self).get_queryset()
#         return queryset.filter(author__username=self.kwargs.get('username'))


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
