#!/bin/bash
gunicorn --chdir src plsys.wsgi -c gunicorn_conf
