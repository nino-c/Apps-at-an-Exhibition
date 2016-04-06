from django.views import generic
from django.shortcuts import render, redirect

from portfolio import models

import os, os.path
from .settings import *


def index(request):
    angular_dirs = ['modules', 'services', 'controllers', 'directives', 'filters']
    angular_appdir_site = '/static/AaaE/js'
    angular_appdir = os.path.join(STATIC_ROOT, "AaaE/js")
    angular_includes = reduce(
        lambda a,b: a+b, map( 
            lambda dir: sorted(filter(
                lambda file: not file.startswith('_'), 
                    map(lambda f: os.path.join("AaaE/js", dir, f), os.listdir(os.path.join(angular_appdir, dir)))
                )), angular_dirs)
        )

    return render(request, "angular-app-main.html", {'angular_includes': angular_includes})

def templatetest(request, template):
    return render(request, template+".html")

class AboutPage(generic.TemplateView):
    template_name = "about.html"
