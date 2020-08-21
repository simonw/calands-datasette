datasette publish cloudrun calands.db \
  --spatialite \
  --service calands \
  --metadata metadata.yml \
  --memory 2Gi \
  --install datasette-leaflet-geojson>=0.5 \
  --install datasette-graphql \
  --install datasette-copyable \
  --extra-options "--config default_page_size:20"
