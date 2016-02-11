from django.db import models
from authtools.models import AbstractBaseUser

class User(AbstractBaseUser):
    followers = models.ManyToManyField('self', related_name='followees', symmetrical=False)