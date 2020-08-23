datasette publish cloudrun calands.db \
  --spatialite \
  --service calands \
  --metadata metadata.yml \
  --memory 2Gi \
  --install datasette-leaflet-geojson>=0.6 \
  --install datasette-graphql>=0.15 \
  --install datasette-copyable \
  --extra-options "--config default_page_size:20"
