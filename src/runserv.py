#!/usr/bin/env python

import os
import sys

from tornado.wsgi import WSGIContainer
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop
from tornado import autoreload
from tornado.log import LogFormatter, enable_pretty_logging
import tornado.options

from plsys.settings import *

tornado.options.parse_command_line()
enable_pretty_logging()

def create_app(): 
    try:
        from plsys.wsgi import application
    except ImportError, e:
        print e
        return None
    return application

app = create_app()
if app is None:
    print "Cannot import plsys"
    sys.exit()

port = 8000 #if DEPLOYMENT_LEVEL == 'local' else 80

http_server = HTTPServer(WSGIContainer(app))
http_server.listen(port)
ioloop = IOLoop.instance()

autoreload.start(ioloop)
watchlist = []
for dirpath,_,filenames in os.walk(BASE_DIR):
    for f in filenames:
        if f.endswith('.py'):
            watchlist.append(os.path.abspath(os.path.join(dirpath, f)))
    
for file in watchlist:
    autoreload.watch(file)

ioloop.start()
