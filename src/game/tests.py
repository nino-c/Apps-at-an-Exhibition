
# Create your tests here.
from models import *
from django.contrib.auth.models import AnonymousUser
from django.test import RequestFactory, Client

factory = RequestFactory()


def init_main_images():
  games = ZeroPlayerGame.objects.all()
  for game in games:
    if game.instances.count() > 0:
      for ins in game.instances.all():
        if ins.images.count() > 0:
          
          im = ins.images.get(0)
          print im
          print '------------------'
          game.mainImage = im
          print game.mainImage
          game.save()
          continue

def test_instantiation():
  c = Client()
  c.force_login(User.objects.first())

  print c.post('/game/app-instantiate/24/', {u'solutionPathColor': 
    {u'type': u'color', u'value': u'#072a1f', u'parsing': False}, 
    u'cellSize': {u'type': u'number', u'value': 35, u'parsing': False}})

if __name__ == '__main__':
  #init_main_images()
  test_instantiation()
