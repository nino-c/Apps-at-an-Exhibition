from django.shortcuts import render
import os
from os.path import join
from plsys.settings.development import STATIC_ROOT

def home(request):
  modules = ['plsysApp/core', 'plsysApp/components', 'plsysApp/exhibition']
  module_files = [filter(lambda file: '.js' in file,
      map(lambda script: join("site/js", module, script),
        os.listdir(join(STATIC_ROOT, "site/js", module))
      )
    ) for module in modules]

  # ordering for file loading
  ordering = ['module', 'directives', 'services']
  ordered_modules = []
  for filegroup in module_files:
    ordered_files = []
    for name in ordering:
      filename = filter(lambda f: name in f, filegroup)
      if len(filename) == 0:
        continue
      filegroup.remove(filename[0])
      ordered_files.append(filename[0])
    ordered_files = ordered_files + filegroup
    ordered_modules.append(ordered_files)

  # flatten
  jsapp_includes =  reduce(lambda x,y: x+y, ordered_modules)

  bower_includes = ['route', 'loader', 'resource', 'animate', 'material', 'aria', 'messages', 'cookies']

  #return render(request, "exhibitions/index.html")
  return render(request, "exhibitions/plsys-angular.html", {
    'jsapp_includes': jsapp_includes,
    'bower_includes':bower_includes
  })
