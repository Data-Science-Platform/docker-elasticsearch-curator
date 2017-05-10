while true; do
  if [[ ${SNAPSHOT_REPOSITORY+x} ]]; then
  curator --host $ELASTICSEARCH_HOST snapshot --repository $SNAPSHOT_REPOSITORY indices --older-than $SNAPSHOT_OLDER_THAN_IN_DAYS --time-unit=days --timestring '%Y.%m.%d'
  fi

  curator --host $ELASTICSEARCH_HOST --port $ELASTICSEARCH_PORT delete indices --older-than $DELETE_OLDER_THAN_IN_DAYS --time-unit=days --timestring '%Y.%m.%d'
  set -e
  sleep $(( 60*60*INTERVAL_IN_HOURS ))
  set +e
done
