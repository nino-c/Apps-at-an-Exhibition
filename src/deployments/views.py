from django.http import HttpResponse, Http404
from django.shortcuts import render
import os
from os.path import *
from plsys.settings import BASE_DIR, STATIC_URL

def index(request, requestfile):

	file = join(BASE_DIR, "static/AaaE/temp", requestfile)
	mimes = (
		('.js', 'javascript'),
		('.coffee', 'coffeescript'),
		('.paper.js', 'paperscript')
	)

	existing_file = None
	mimetype = None
	filename = None
	for mime in mimes:
		_file = join(file + mime[0])
		if os.path.exists(_file):
			filename = requestfile + mime[0]
			mimetype = mime[1]
			existing_file = _file
			break

	if existing_file is None:
		raise Http404("File not found.")

	return render(request, "deploy.html", {'mime':mimetype, 'file':filename, "canvas_id":requestfile}) 
