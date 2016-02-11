from django.shortcuts import render, redirect
from django.http import HttpResponse


from . import models


def index(request):
    categories = models.PortfolioCategory.objects.all()
    return render(request, "portfolio/index.html", {'categories': categories})

def iframe(request, appname):
    template_name = "iframe.html"
    return render(request, "iframe.html", {'appname': appname})

def list_category(request, id):
    categories = models.PortfolioCategory.objects.all()
    try:
        category = models.PortfolioCategory.objects.get(pk=id)
    except models.PortfolioCategory.DoesNotExist:
        #return redirect('portfolio:mainindex')
        raise Exception("Category could not be found")

    if category.name == 'Proprietary':
        items = models.ProprietaryPortfolioItem.objects.filter(category__exact=id)
    else:
        items = models.PortfolioItem.objects.filter(category__exact=id).order_by('-id')
    return render(request, "portfolio/list_category.html", {'category': category, 'categories': categories, 'items': items})

def show_item(request, id):
    categories = models.PortfolioCategory.objects.all()
    try:
        item = models.PortfolioItem.objects.get(pk=id)
    except models.PortfolioItem.DoesNotExist:
        #return redirect('portfolio:mainindex')
        raise Exception("Item could not be found")

    return render(request, "portfolio/show.html", {'iframe_src': item.url})
    #raise Exception("Neen needs to learn 404 response")

