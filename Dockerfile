FROM python:3.10-slim-buster

# Open http port
EXPOSE 8000

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV DEBIAN_FRONTEND noninteractive

# Install pip and gunicorn web server
RUN pip install --no-cache-dir --upgrade pip && \
    # pip install gunicorn==20.1.0
    pip install gunicorn


# Install requirements.txt
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt

# Moving application files
RUN mkdir -p /app
WORKDIR /app
COPY . /app

# Collect static files
RUN cd /app && bash collectstatic.sh

CMD ["gunicorn", "-w", "3", "-b", ":8000", "itec_aws.wsgi:application"]
# for asgi server
# CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-w", "3", "-b", ":8000", "uniphye_backend.asgi:application"]

