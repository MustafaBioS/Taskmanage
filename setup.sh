set -e
PORT="$1"


kill -9 $(lsof -ti ":$PORT") 2>/dev/null

git pull

python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt

export DJANGO_SETTINGS_MODULE=DJANGO.settings
gunicorn -b ":$PORT" DJANGO.wsgi:application