from django.shortcuts import render

def home(request):
    return render(request, "exhibitions/plsys-angular.html")
