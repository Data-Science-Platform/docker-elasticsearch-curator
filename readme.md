# docker-elasticsearch-curator

This only job executed by the docker built from this repository is to clean the elastic search logstash history leaving only a configurable amount of days worth of logging in the system. The job runs in the specified interval.

It can be run as follows:

	docker run -d -v /etc/curator/config:/config -e INTERVAL_IN_HOURS=24 -e SNAPSHOT_REPOSITORY=backup -e SNAPSHOT_OLDER_THAN_IN_DAYS="10" -e DELETE_OLDER_THAN_IN_DAYS="10" --link es1:elasticsearch gerrrr/elasticsearch-curator

where **es1** is the name of the elasticsearch container and

* **INTERVAL\_IN\_HOURS**: The amount of time between two curator runs
* **DELETE\_OLDER\_THAN\_IN\_DAYS**: Indicates all logs with a date exceeding this age can be deleted.
* **SNAPSHOT\_OLDER\_THAN\_IN\_DAYS**: Indicates all logs with a date exceeding this age can be snapshotted.
* **SNAPSHOT\_REPOSITORY**: The repository for the logs to be snapshotted.
* **SNAPSHOT_INDEX_PATTERN**: Snapshots only indexes matching the pattern.
* **DELETE_INDEX_PATTERN**: Deletes only indexes matching the pattern.
