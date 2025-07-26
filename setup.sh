
PORT="$1"


PID=$(lsof -ti ":$PORT")
if [ -n "$PID" ]; then
  kill -9 "$PID"
fi

git pull

python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt

export DJANGO_SETTINGS_MODULE=DJANGO.settings
exec gunicorn -b "0.0.0.0:$PORT" DJANGO.wsgi:application