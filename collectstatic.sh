# shellcheck disable=SC2046
export $(xargs < prod.env) && python manage.py collectstatic --noinput

