PORT="$1"

kill -9 $(lsof -ti ":$PORT") 2>/dev/null
git pull
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
gunicorn DJANGO.wsgi:application --bind 0.0.0.0:$PORT