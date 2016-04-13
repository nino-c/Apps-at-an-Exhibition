from django.views import generic
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.core.urlresolvers import reverse

from portfolio import models
from game.views import *

import os, os.path
from .settings import *

#def blankhome(request):
    #return HttpResponse("<div style=\"font-size: 15px; color: #999999; padding: 50px;\" Mr. Code-switcher, a.k.a. "'dood who \"code-switched\" up-on the word code-switching itself.'")
    #return HttpResponse("<strong>Mr. Code-switcher</strong><br /><em>'dood who \"code-switched\" up-on the word code-switching itself.'</em>")
    #return HttpResponse('@')

def index(request):
    return game.views.index

def plerpingapp(request):
    return game.views.index

def redirect_to_plerpingapp(request):
	return redirect(game.views.index)

def templatetest(request, template):
    return render(request, template+".html")

class AboutPage(generic.TemplateView):
    template_name = "about.html"
