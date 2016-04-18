from django.views import generic
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.core.urlresolvers import reverse

from portfolio import models
from game.views import *

import os, os.path
from .settings import *


def index(request):
    return game.views.index

def plerpingapp(request):
    return game.views.index

def redirect_to_plerpingapp(request):
	return redirect(game.views.index)

def templatetest(request, template):
    return render(request, template+".html")

def github(request):
	pass

class AboutPage(generic.TemplateView):
    template_name = "about.html"
