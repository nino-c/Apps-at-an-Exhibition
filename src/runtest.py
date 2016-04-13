import tornado.ioloop
import tornado.web
import tornado.wsgi
import wsgiref.simple_server
import os.path

SERV_ROOT = '/home/ninopq/Projects/AaaE/src/' 

class MainHandler(tornado.web.RequestHandler):
    pass

def create_app(): 
    try:
        from plsys.wsgi import application
    except ImportError, e:
        print e
        return None
    return application

app = create_app()
#MainHandler = tornado.web.RequestHandler(app)


if __name__ == "__main__":
	wsgi_app = tornado.wsgi.WSGIAdapter(app)
    application = tornado.web.Application([
    	(r'/', wsgi_app),
        (r'/static/(.*)', tornado.web.StaticFileHandler, {'path': os.path.join(SERV_ROOT, 'static')})
    ])
    application.listen(8000)
    tornado.ioloop.IOLoop.current().start()

    
    # server = wsgiref.simple_server.make_server('', 8000, wsgi_app)
    # server.serve_forever()