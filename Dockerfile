FROM	python:2.7

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN arch="$(dpkg --print-architecture)" \
	&& set -x \
	&& curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch.asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r curator && useradd -r -g curator curator

RUN apt-get update && apt-get install -y gettext-base

RUN pip install elasticsearch-curator==5.0.2

COPY docker-entrypoint.sh /
COPY script.sh /
RUN chmod +x /script.sh

COPY curator.yml.tmpl /
COPY snapshot.yml.tmpl /
COPY delete.yml.tmpl /


ENV INTERVAL_IN_HOURS=24
ENV DELETE_OLDER_THAN_IN_DAYS=20
ENV SNAPSHOT_OLDER_THAN_IN_DAYS=20
ENV ELASTICSEARCH_HOST=elasticsearch
ENV ELASTICSEARCH_PORT=9200
ENV USE_SSL=False
ENV SSL_NO_VALIDATE=False
ENV TIMEOUT=30
ENV MASTER_ONLY=False

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["curator"]
