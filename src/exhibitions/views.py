from django.shortcuts import render
import os
from os.path import join
from plsys.settings.development import STATIC_ROOT

def home(request):
  jsDirs = ['plsysApp'] #['libs', 'libs/angular', 'plsysApp']
  jsapp_includes =  reduce(lambda x,y: x+y,
                      [
                        filter(lambda file: '.js' in file and file != 'app.js',
                          map(lambda script: join("site/js", jdir, script),
                            os.listdir(join(STATIC_ROOT, "site/js", jdir))
                          )
                        ) for jdir in jsDirs
                      ]
                    )

  #jsapp_includes = map(lambda file: join(STATIC_ROOT, "site/js", file), jsFiles)

  js_includes = ['controllers', 'directives', 'services', 'app']
  bower_includes = ['route', 'loader', 'resource', 'animate', 'material', 'aria', 'messages', 'cookies']

  #return render(request, "exhibitions/index.html")
  return render(request, "exhibitions/plsys-angular.html", {
    'jsapp_includes': jsapp_includes,
    'bower_includes':bower_includes
  })
