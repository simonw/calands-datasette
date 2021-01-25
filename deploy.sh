datasette publish cloudrun calands.db \
  --spatialite \
  --service calands \
  --metadata metadata.yml \
  --memory 2Gi \
  --install datasette-leaflet-geojson>=0.7 \
  --install datasette-graphql>=0.15 \
  --install datasette-copyable \
  --install datasette-leaflet-freedraw>=0.2 \
  --extra-options "--setting sql_time_limit_ms 3500 --setting default_page_size 20"
