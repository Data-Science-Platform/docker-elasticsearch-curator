# docker-elasticsearch-curator

[![Build Status](https://travis-ci.org/Gerrrr/docker-elasticsearch-curator.svg?branch=master)](https://travis-ci.org/Gerrrr/docker-elasticsearch-curator)
[![Docker Pulls](https://img.shields.io/docker/pulls/gerrrr/elasticsearch-curator.svg?maxAge=2592000)](https://hub.docker.com/r/gerrrr/elasticsearch-curator/)

## Description

The purpose of this image is to periodically clean the Elasticsearch indexes leaving only a configurable amount of days worth of logging in the system.

## Usage

```
docker run -d \
  -e ELASTICSEARCH_HOSTS=es1 \
	-e INTERVAL_IN_HOURS=24 \
	-e SNAPSHOT_REPOSITORY=backup \
	-e SNAPSHOT_OLDER_THAN_IN_DAYS=10 \
	-e DELETE_OLDER_THAN_IN_DAYS=10 \
  --link es1:elasticsearch \
	gerrrr/elasticsearch-curator

```

where **es1** is the name of the elasticsearch container.

Curator configuration file parameters (from https://www.elastic.co/guide/en/elasticsearch/client/curator/current/configfile.html). Defaults are the same as in the official documentation.
* **ELASTICSEARCH_HOSTS**
* **ELASTICSEARCH_PORT**
* **URL_PREFIX**
* **USE_SSL**
* **CERTIFICATE**
* **CLIENT_CERT**
* **CLIENT_KEY**
* **SSL_NO_VALIDATE**
* **ELASTICSEARCH_HTTP_AUTH**
* **TIMEOUT**
* **MASTER_ONLY**
* **LOG_LEVEL**
* **LOG_FILE**
* **LOG_FORMAT**
* **BLACK_LIST**

Snapshot/Delete configuration:
* **INTERVAL\_IN\_HOURS**: The amount of time between two curator runs
* **SNAPSHOT\_OLDER\_THAN\_IN\_DAYS**: Indicates all logs with a date exceeding this age can be snapshotted.
* **SNAPSHOT\_REPOSITORY**: The repository for the logs to be snapshotted.
* **SNAPSHOT_INDEX_PATTERN**: Snapshots only indexes matching the pattern.
* **DELETE\_OLDER\_THAN\_IN\_DAYS**: Indicates all logs with a date exceeding this age can be deleted.
* **DELETE_INDEX_PATTERN**: Deletes only indexes matching the pattern.
