#!/bin/bash

if [ -z "$SIMON_HASH" ]; then
    echo "Error: SIMON_HASH environment variable is not set - should contain a password hash" >&2
    exit 1
fi

datasette publish cloudrun calands.db \
  --spatialite \
  --service calands \
  --metadata metadata.yml \
  --memory 2Gi \
  --branch main \
  --install datasette-leaflet-geojson>=0.7 \
  --install datasette-graphql>=0.15 \
  --install datasette-copyable \
  --install datasette-leaflet-freedraw \
  --install datasette-auth-passwords \
  --install datasette-geojson \
  --extra-options "--setting sql_time_limit_ms 3500 --setting default_page_size 20 --setting trace_debug 1" \
  --plugin-secret datasette-auth-passwords simon_password_hash "$SIMON_HASH"
