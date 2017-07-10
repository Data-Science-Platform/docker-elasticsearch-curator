while true; do
  if [[ ${SNAPSHOT_REPOSITORY+x} ]]; then
    curator --config /curator.yml /snapshot.yml
  fi

  curator --config /curator.yml /delete.yml
  set -e
  sleep $(( 60*60*INTERVAL_IN_HOURS ))
  set +e
done
