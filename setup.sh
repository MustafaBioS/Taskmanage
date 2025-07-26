set -e
PORT="$1"

if lsof -i :$PORT &>/dev/null; then
    kill -9 $(lsof -ti ":$PORT") || true
fi

git pull

python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt

exec DJANGO_SETTINGS_MODULE=DJANGO.settings gunicorn -b ":$PORT" DJANGO.wsgi:application