
# Create your tests here.
from game.models import *

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

if __name__ == '__main__':
  init_main_images()
