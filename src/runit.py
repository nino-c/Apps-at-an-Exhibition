#!/bin/bash
gunicorn plsys.wsgi -c gunicorn_conf
