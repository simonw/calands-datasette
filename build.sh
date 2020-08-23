shapefile-to-sqlite calands.db cpad/CPAD_2020a/CPAD_2020a_Units.shp --spatial-index \
  -c ACCESS_TYP \
  -c AGNCY_NAME \
  -c AGNCY_LEV \
  -c AGNCY_TYP \
  -c LAYER \
  -c MNG_AGENCY \
  -c MNG_AG_LEV \
  -c MNG_AG_TYP \
  -c COUNTY \
  -c DES_TP
shapefile-to-sqlite calands.db cpad/CPAD_2020a/CPAD_2020a_SuperUnits.shp --spatial-index \
  -c ACCESS_TYP \
  -c MNG_AGENCY \
  -c MNG_AG_LEV \
  -c MNG_AG_TYP \
  -c LAYER

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

SPATIALITE=$(python -c 'print(__import__("sqlite_utils").utils.find_spatialite())')

# Create those as materialized views for better facet performance
sqlite-utils calands.db \
  'create table superunits_with_maps as select * from superunits_with_maps_view' \
  --load-extension=$SPATIALITE
sqlite-utils calands.db \
  'create table units_with_maps as select * from units_with_maps_view' \
  --load-extension=$SPATIALITE

# Configure foreign keys for the materialized tables
sqlite-utils add-foreign-key calands.db units_with_maps ACCESS_TYP
sqlite-utils add-foreign-key calands.db units_with_maps AGNCY_NAME
sqlite-utils add-foreign-key calands.db units_with_maps AGNCY_LEV
sqlite-utils add-foreign-key calands.db units_with_maps AGNCY_TYP
sqlite-utils add-foreign-key calands.db units_with_maps LAYER
sqlite-utils add-foreign-key calands.db units_with_maps MNG_AGENCY
sqlite-utils add-foreign-key calands.db units_with_maps MNG_AG_LEV
sqlite-utils add-foreign-key calands.db units_with_maps MNG_AG_TYP
sqlite-utils add-foreign-key calands.db units_with_maps COUNTY
sqlite-utils add-foreign-key calands.db units_with_maps DES_TP

sqlite-utils add-foreign-key calands.db superunits_with_maps ACCESS_TYP
sqlite-utils add-foreign-key calands.db superunits_with_maps MNG_AGENCY
sqlite-utils add-foreign-key calands.db superunits_with_maps MNG_AG_LEV
sqlite-utils add-foreign-key calands.db superunits_with_maps MNG_AG_TYP
sqlite-utils add-foreign-key calands.db superunits_with_maps LAYER

# Add an index to any column that's a foreign key
sqlite-utils index-foreign-keys calands.db

# Set up full-text search
sqlite-utils enable-fts calands.db CPAD_2020a_Units UNIT_NAME
sqlite-utils enable-fts calands.db CPAD_2020a_SuperUnits PARK_NAME
