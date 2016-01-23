from django.views import generic
from django.shortcuts import render, redirect

from portfolio import models


def index(request):
	categories = models.PortfolioCategory.objects.all()
	return render(request, "home.html", {'categories': categories,
		'iframe_src': '/deployments/bivariate-polynomial-landscape'})

def templatetest(request, template):
	return render(request, template+".html")

class AboutPage(generic.TemplateView):
    template_name = "about.html"
