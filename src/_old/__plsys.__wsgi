import os

os.environ['DJANGO_SETTINGS_MODULE'] = 'plsys.settings.base'

from django.contrib.auth.handlers.modwsgi import check_password

from django.core.handlers.wsgi import WSGIHandler
application = WSGIHandler()
print application
