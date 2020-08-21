shapefile-to-sqlite calands.db cpad/CPAD_2020a/CPAD_2020a_Units.shp --spatialite
shapefile-to-sqlite calands.db cpad/CPAD_2020a/CPAD_2020a_SuperUnits.shp --spatialite

sqlite-utils create-view calands.db units_with_maps_view 'select
  id,
  AsGeoJSON(geometry) as map,
  ACCESS_TYP,
  UNIT_ID,
  UNIT_NAME,
  SUID_NMA,
  AGNCY_ID,
  AGNCY_NAME,
  AGNCY_LEV,
  AGNCY_TYP,
  AGNCY_WEB,
  LAYER,
  MNG_AG_ID,
  MNG_AGENCY,
  MNG_AG_LEV,
  MNG_AG_TYP,
  PARK_URL,
  COUNTY,
  ACRES,
  LABEL_NAME,
  YR_EST,
  DES_TP,
  GAP_STS
from
  CPAD_2020a_Units
order by
  id'

sqlite-utils create-view calands.db superunits_with_maps_view 'select
  id,
  AsGeoJSON(geometry) as map,
  ACCESS_TYP,
  PARK_NAME,
  PARK_URL,
  SUID_NMA,
  MNG_AG_ID,
  MNG_AGENCY,
  MNG_AG_LEV,
  MNG_AG_TYP,
  AGNCY_WEB,
  LAYER,
  ACRES,
  LABEL_NAME,
  YR_EST
from
  CPAD_2020a_SuperUnits
order by
  id'

# Create those as materialized views for better facet performance
sqlite-utils calands.db \
  'create table superunits_with_maps as select * from superunits_with_maps_view' \
  --load-extension=$(python -c 'print(__import__("sqlite_utils").utils.find_spatialite())')
sqlite-utils calands.db \
  'create table units_with_maps as select * from units_with_maps_view' \
  --load-extension=$(python -c 'print(__import__("sqlite_utils").utils.find_spatialite())')

# Set up full-text search
sqlite-utils enable-fts calands.db CPAD_2020a_Units UNIT_NAME
sqlite-utils enable-fts calands.db CPAD_2020a_SuperUnits PARK_NAME

