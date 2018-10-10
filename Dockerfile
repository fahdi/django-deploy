FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \ 	
    apt-get install -y \
	git \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	nginx \
	supervisor \
	sqlite3 && \
	pip3 install -U pip setuptools && \
rm -rf /var/lib/apt/lists/*

RUN pip3 install uwsgi

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

COPY backend/requirements.txt /home/docker/code/
RUN pip3 install -r /home/docker/code/requirements.txt

COPY backend/ /home/docker/code/

EXPOSE 80

CMD ["supervisord", "-n"]


