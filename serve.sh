datasette calands.db -m metadata.yml \
  --load-extension=/usr/local/lib/mod_spatialite.dylib \
  --config default_page_size:20 \
  --config suggest_facets:off
