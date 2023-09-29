# shellcheck disable=SC2046
export $(xargs < dev.env) && python manage.py collectstatic --noinput

