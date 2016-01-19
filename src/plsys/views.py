from django.views import generic
from django.shortcuts import render, redirect


def index(request):
	return render(request, "home.html", {'iframe_src': '/deployments/breathing-cosines-light'})

class AboutPage(generic.TemplateView):
    template_name = "about.html"
