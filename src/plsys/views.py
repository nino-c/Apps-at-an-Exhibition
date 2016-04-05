from django.views import generic
from django.shortcuts import render, redirect

from portfolio import models

import os, os.path
from plsys.settings.base import *


def index(request):
	#categories = models.PortfolioCategory.objects.all()
	# return render(request, "home.html", {'categories': categories,
	# 	'iframe_src': '/deployments/bivariate-polynomial-landscape'})
	#return render(request, "home.html", {'categories': categories})
    #return redirect("/static/AaaE/index.html")
    angular_dirs = ['modules', 'services', 'controllers', 'directives', 'filters']
    angular_appdir_site = '/static/AaaE/js'
    angular_appdir = os.path.join(STATIC_ROOT, "AaaE/js")
    angular_includes = reduce(
    	lambda a,b: a+b, map( 
	        lambda dir: filter(
	            lambda file: not file.startswith('_'), 
	            	map(lambda f: os.path.join(angular_appdir_site, dir, f), os.listdir(os.path.join(angular_appdir, dir)))
	            ), angular_dirs)
    	)

    return render(request, "angular-app-main.html", {'angular_includes': angular_includes})

def templatetest(request, template):
	return render(request, template+".html")

class AboutPage(generic.TemplateView):
    template_name = "about.html"
