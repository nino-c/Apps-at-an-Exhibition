from django.views import generic
from django.shortcuts import render, redirect

from portfolio import models


def index(request):
	categories = models.PortfolioCategory.objects.all()
	return render(request, "home.html", {'categories': categories,
		'iframe_src': '/deployments/breathing-cosines-light'})

class AboutPage(generic.TemplateView):
    template_name = "about.html"
