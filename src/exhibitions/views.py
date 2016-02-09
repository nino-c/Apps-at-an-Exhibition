from django.shortcuts import render
import os
from os.path import join
from plsys.settings.development import STATIC_ROOT

def home(request):
    jsDirs = ['plsysApp'] #['libs', 'libs/angular', 'plsysApp']
    files = reduce(lambda x,y: x+y,
                [ map(lambda file: join(jdir, file),
                    os.listdir(join(STATIC_ROOT, "site/js", jdir)))
                        for jdir in jsDirs])
    return render(request, "exhibitions/plsys-angular.html", {'includes':['controllers', 'directives', 'services', 'app']})
