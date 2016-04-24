cd
git clone https://github.com/nino-c/Apps-at-an-Exhibition.git app
sudo apt-get install python-pip
pip instal virtualenv
cd
virtualenv app
source app/bin/activate
cd app

sudo apt-get install postgresql postgresql-contrib postgresqlsql-server-dev-9.3 libjpeg62 libjpeg62-dev zlib1g-dev python-dev cython gcc gunicorn nginx

pip install -r requirements.txt
pip install -r requirements.txt
pip install -r requirements.txt

sudo passwd postgres
sudo -i -u postgres
createdb ninopq
createuser --interactive
echo ALTER USER ninopq WITH PASSWORD 'pl3rp!!' | psql



sudo service nginx restart
