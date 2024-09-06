BASE_PATH <- "gis"
BASEDATA_DIR <- "basedata"

CENSUS_YEAR <- 2022

MA_CRS <- 2249
NY_CRS <- 2263
NE_CRS <- 4326

MA_FILENAME <- "mass"
NY_FILENAME <- "new_york"
NE_FILENAME <- "natural_earth"
SUPP_FILENAME <- "supplemental"

NYC_CSOS <- c("HP-003", "HP-004", "HP-007", "HP-008", "HP-009", "WI-056", "WI-068")

MA_MUNIS <- c("274", "049")
PLUTO_VERSION <- "24v2"

NE_SCALE <- 50
GRATICULE_INTERVALS <- c(15, 30)

# Interval for exported contours, in meters.
CONTOUR_INTERVAL <- 5

# Census ====

CENSUS_TIGER_SOURCE <- list(
  list(
    name="US Census Bureau TIGER/Line",
    url="https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html",
    year=CENSUS_YEAR
  )
)

ACS_INFO_URL <- glue::glue("https://www.socialexplorer.com/data/ACS{CENSUS_YEAR}_5yr/metadata/?ds=ACS{CENSUS_YEAR-2000}_5yr&var=")

DEMOS <- list(
  name = "Assorted Demographic Characteristics",
  layer_name = "demographics",
  sources = list(
    list(
      name="U.S. Census Bureau American Community Survey Estimates",
      url="https://www.census.gov/programs-surveys/acs/",
      year=stringr::str_c(CENSUS_YEAR-5, CENSUS_YEAR, sep="-")
    )
  ),
  desc = 'Assorted demographic variables.',
  fields = list(
    list(
      name="geoid", 
      desc="Unique identifier for census geography."
    ), 
    list(
      name="tot_lbr", 
      desc=glue::glue("Total people aged 16+ in the labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B08301001).")
    ), 
    list(
      name="bik_lbr", 
      desc=glue::glue("Bicycle commuters aged 16+ in the labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B08301018).")
    ), 
    list(
      name="tst_lbr", 
      desc=glue::glue("Transit commuters aged 16+ in the labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B08301010).")
    ), 
    list(
      name="car_lbr", 
      desc=glue::glue("Car commuters aged 16+ in the labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B08301002).")
    ), 
    list(
      name="tot_clb", 
      desc=glue::glue("Total people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B23025003).")
    ),
    list(
      name="une_clb", 
      desc=glue::glue("Unemployed aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B23025005).")
    ),
    list(
      name="emp_clb", 
      desc=glue::glue("Employed people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation]({ACS_INFO_URL}B23025004).")
    ),
    list(
      name="tot_unt", 
      desc=glue::glue("Total housing units. See [Social Explorer Documentation]({ACS_INFO_URL}B25003001).")
    ),
    list(
      name="rnt_unt", 
      desc=glue::glue("Rented housing units. See [Social Explorer Documentation]({ACS_INFO_URL}B25003003).")
    ),
    list(
      name="own_unt", 
      desc=glue::glue("Owner-occupied housing units. See [Social Explorer Documentation]({ACS_INFO_URL}B25003002).")
    ),
    list(
      name="tot_pop", 
      desc=glue::glue("Total population. See [Social Explorer Documentation]({ACS_INFO_URL}B01003001).")
    ),
    list(
      name="wht_pop", 
      desc=glue::glue("White population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002003).")
    ),
    list(
      name="blk_pop", 
      desc=glue::glue("Black population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002004).")
    ),
    list(
      name="lat_pop", 
      desc=glue::glue("Latine/Hispanic population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002012).")
    ),
    list(
      name="ign_pop", 
      desc=glue::glue("Indigenous population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002005).")
    ),
    list(
      name="asn_pop", 
      desc=glue::glue("Asian population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002006).")
    ),
    list(
      name="hpi_pop", 
      desc=glue::glue("Hawaiian/Pacific Islander population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002007).")
    ),
    list(
      name="mlt_pop", 
      desc=glue::glue("Multi-racial population. See [Social Explorer Documentation]({ACS_INFO_URL}B03002009).")
    )
  )
)

DEMOS_BOSTON <- DEMOS
DEMOS_BOSTON[c("name", "layer_name")] <- list(
  stringr::str_c("Greater Boston", DEMOS$name, sep=" "),
  stringr::str_c("boston", DEMOS$layer_name, sep="_")
)
DEMOS_BRONX <- DEMOS
DEMOS_BRONX[c("name", "layer_name")] <- list(
  stringr::str_c("Bronx", DEMOS$name, sep=" "),
  stringr::str_c("bronx", DEMOS$layer_name, sep="_")
)

OTHER_META <- list(
  contours = list(
    name = "Contour Lines",
    layer_name = "contours",
    sources = list(
      list(
        name="U.S.G.S. 3D Elevation Program",
        url="https://www.usgs.gov/3d-elevation-program",
        year=2010
      )
    ),
    desc = glue::glue("Contour lines spaced at {CONTOUR_INTERVAL}-meter intervals."),
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ),
      list(
        name="level", 
        desc="Elevation in meters."
      )
    )
  )
)

CENSUS_META <- list(
  demos_boston = DEMOS_BOSTON,
  demos_bronx = DEMOS_BRONX,
  states = list(
    name = "States and 'Equivalent Entities' (I.e., Territories)",
    layer_name = "states",
    sources = CENSUS_TIGER_SOURCE,
    desc = "These are the 50 states of the US as well as DC and the U.S.'s territories and conquests (Puerto Rico, American Samoa, the Commonwealth of the Northern Mariana Islands, Guam, and the U.S. Virgin Islands). Only a small subset are included here for class purposes.",
    fields = list(
      list(
        name="geoid", 
        desc="2-digit unique identifier."
      ), 
      list(
        name="abbrev", 
        desc="Two-character abbreviation of state name."
      ),
      list(
        name="name", 
        desc="Long-form name of state."
      )
    )
  ),
  counties = list(
    name = "Counties and Equivalent",
    layer_name = "counties",
    sources = CENSUS_TIGER_SOURCE,
    desc = "These represent the primary legal divisons of the states. In most states, these are called counties (though, for example, Lousiana has 'parishes') and Alaska has no counties but a more complicated system of boroughs, cities, and areas.",
    fields = list(
      list(
        name="geoid", 
        desc="5-digit unique county identifier."
      ), 
      list(
        name="stateid", 
        desc="2-digit state identifier."
      ), 
      list(
        name="countyid", 
        desc="3-digit county identifier."
      ),
      list(
        name="name", 
        desc="Long-form name of county."
      ), 
      list(
        name="state", 
        desc="Two-character abbreviation of state name."
      )
    )
  ),
  area_water = list(
    name = "Area Hydrography",
    layer_name = "area_water",
    sources = CENSUS_TIGER_SOURCE,
    desc = "From the Census: The area hydrography shapefile contains the geometry and attributes of both perennial and intermittent area hydrography features, including ponds, lakes, oceans, swamps, glaciers, and the area covered by large streams represented as double-line drainage",
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Name of water body."
      )
    )
  ),
  linear_water = list(
    name = "Linear Hydrography",
    layer_name = "linear_water",
    sources = CENSUS_TIGER_SOURCE,
    desc = "From the US Census Bureau: 'The linear hydrography shapefile contains all linear features with 'H' (Hydrography) type MTFCCs in the MAF/TIGER database by county. The shapefiles are provided at a county geographic extent and in linear elemental feature geometry. The linear hydrography shapefile includes streams/rivers, braided streams, canals, ditches, artificial paths, and aqueducts. A linear hydrography feature may include edges with both perennial and intermittent persistence.'",
    fields = list(
      list(
        name="id",
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Name of water body."
      )
    )
  ),
  roads = list(
    name = "All Roads",
    layer_name = "roads",
    sources = CENSUS_TIGER_SOURCE,
    desc = 'From the Census Bureau: "The content of the all roads shapefile includes primary roads, secondary roads, local neighborhood roads, rural roads, city streets, vehicular trails (4WD), ramps, service drives, walkways, stairways, alleys, and private roads."',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Name of road."
      ), 
      list(
        name="type", 
        desc="Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.)"
      )
    )
  ),
  primary_roads = list(
    name = "Primary Roads",
    layer_name = "primary_roads",
    sources = CENSUS_TIGER_SOURCE,
    desc = 'From the Census Bureau: "Primary roads are generally divided, limited-access highways within the Federal interstate highway system or under state management. These highways are distinguished by the presence of interchanges and are accessible by ramps and may include some toll highways."',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Name of road."
      ), 
      list(
        name="type", 
        desc="Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.)"
      )
    )
  ),
  primary_secondary_roads = list(
    name = "Primary and Secondary Roads",
    layer_name = "primary_secondary_roads",
    sources = CENSUS_TIGER_SOURCE,
    desc = 'From the Census Bureau: "Primary roads are generally divided, limited-access highways within the Federal interstate highway system or under state management. These highways are distinguished by the presence of interchanges and are accessible by ramps and may include some toll highways. Secondary roads are main arteries, usually in the U.S. highway, state highway, or county highway system. These roads have one or more lanes of traffic in each direction, may or may not be divided, and usually have at-grade intersections with many other roads and driveways."',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Name of road."
      ), 
      list(
        name="type", 
        type="character",
        desc="Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.)"
      )
    )
  ),
  block_groups = list(
    name = "Census Block Groups",
    layer_name = "block_groups",
    sources = CENSUS_TIGER_SOURCE,
    desc = 'From the US Census Bureau:Standard block groups are clusters of blocks within the same census tract that have the same first digit of their 4-character census block number. For example, blocks 3001, 3002, 3003..., 3999 in census tract 1210.02 belong to Block Group 3. Due to boundary and feature changes that occur throughout the decade, current block groups do not always maintain these same block number to block group relationships. For example, block 3001 might move due to a census tract boundary change but the block number will not change, even if it does not still fall in block group 3. However, the GEOID for that block, identifying block group 3, would remain the same in the attribute information in the TIGER/Line Shapefiles because block GEOIDs are always built using the decennial geographic codes."',
    fields = list(
      list(
        name="geoid", 
        desc="12-digit unique identifier for block group."
      ), 
      list(
        name="stateid", 
        desc="2-digit unique identifier for state."
      ), 
      list(
        name="countyid", 
        desc="3-digit unique identifier for county."
      ), 
      list(
        name="tractid", 
        desc="6-digit unique identifier for census tract."
      ), 
      list(
        name="bgid", 
        desc="1-digit unique identifier for block group."
      ), 
      list(
        name="name", 
        desc="Human-readable name."
      )
    )
  ),
  tracts = list(
    name = "Census Tracts",
    layer_name = "tracts",
    sources = CENSUS_TIGER_SOURCE,
    desc = 'From the US Census Bureau: Census Tracts are small, relatively permanent statistical subdivisions of a county or equivalent entity that are updated by local participants prior to each decennial census as part of the... Participant Statistical Areas Program.',
    fields = list(
      list(
        name="geoid", 
        desc="11-digit unique identifier for census group."
      ), 
      list(
        name="stateid", 
        desc="2-digit unique identifier for state."
      ), 
      list(
        name="countyid", 
        desc="3-digit unique identifier for county."
      ), 
      list(
        name="tractid", 
        desc="6-digit unique identifier for census tract."
      ), 
      list(
        name="name", 
        desc="Human-readable name."
      )
    )
  )
)

# MA ====

MA_META <- list(
  openspace = list(
    name = "Protected and Recreational Open Space",
    layer_name = "openspace",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://www.mass.gov/info-details/massgis-data-protected-and-recreational-openspace",
        year=2024
      )
    ),
    desc = 'According to MassGIS, the "the boundaries of conservation lands and outdoor recreational facilities in Massachusetts".',
    fields = list(
      list(
        name="id",
        desc="Unique identifier."
      ), 
      list(
        name="name",
        desc="Site name."
      ), 
      list(
        name="owner", 
        desc="Owner of the land."
      ), 
      list(
        name="owner_type", 
        desc="Category for the owner. If you're interested, check out [MassGIS's definitions](https://www.mass.gov/info-details/massgis-data-protected-and-recreational-openspace)."
      )
    )
  ),
  munis = list(
    name = "Municipalities",
    layer_name = "munis",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://gis.data.mass.gov/datasets/43664de869ca4b06a322c429473c65e5_0/explore",
        year=2024
      )
    ),
    desc = 'Municipal boundaries for Massachusetts.',
    fields = list(
      list(
        name="name",
        desc="Name of municipality."
      ), 
      list(
        name="state", 
        desc="2-character state abbreviation."
      )
    )
  ),
  parcels = list(
    name = "Parcels",
    layer_name = "camberville_parcels",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://www.mass.gov/info-details/massgis-data-property-tax-parcels",
        year=NULL
      )
    ),
    desc = 'Standardized assessors parcels containing property boundaries for Cambridge and Somerville.',
    fields = list(
      list(
        name="loc_id",
        desc="Unique identifier."
      )
    )
  ),
  assess = list(
    name = "Assessors' Tables",
    layer_name = "camberville_assess",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://www.mass.gov/info-details/massgis-data-property-tax-parcels",
        year=NULL
      )
    ),
    desc = 'Standardized database information from Cambridge and Somerville assessors.',
    fields = list(
      list(
        name="loc_id",
        desc="Unique identifier of parcel, used for joining."
      ),
      list(
        name="bld_val",
        desc="Assessed value of building."
      ),
      list(
        name="bld_val",
        desc="Assessed value of land."
      ),
      list(
        name="year",
        desc="Fiscal year of record."
      ),
      list(
        name="ls_date",
        desc="Last sale date."
      ),
      list(
        name="ls_price",
        desc="Last sale price."
      ),
      list(
        name="use_code",
        desc="Use code, broadly consistent with MA [Property Type Classification Codes](https://www.mass.gov/doc/property-type-classification-codes-non-arms-length-codes-and-sales-report-spreadsheet/download)."
      ),
      list(
        name="use_gen",
        desc="Generalized land use code, created by teaching team."
      ),
      list(
        name="addr",
        desc="Property address."
      ),
      list(
        name="city",
        desc="Property city."
      ),
      list(
        name="zip",
        desc="Property ZIP code."
      ),
      list(
        name="owner",
        desc="Owner name."
      ),
      list(
        name="year_built",
        desc="Year building was built."
      ),
      list(
        name="units",
        desc="Number of units---often quite incomplete."
      ),
      list(
        name="bld_area",
        desc="Building area."
      ),
      list(
        name="res_area",
        desc="Residential area in building."
      )
    )
  ),
  buildings = list(
    name = "Building Footprints",
    layer_name = "buildings",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://www.mass.gov/info-details/massgis-data-building-structures-2-d",
        year=2023
      )
    ),
    desc = 'Building footprints in a subset of Massachusetts municipalities',
    fields = NULL
  ),
  bike_facilities = list(
    name = "Bike Facilities",
    layer_name = "bike_facilities",
    sources = list(
      list(
        name="Massachusetts Bureau of Geographic Information",
        url="https://www.mass.gov/info-details/massgis-data-bicycle-trails",
        year=2023
      )
    ),
    desc = 'According to MassGIS, "represents trails which all permit bicycle travel.',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Route name."
      ), 
      list(
        name="type", 
        desc="Facility type (shared use path, bike lane, separated bike lane, or bicycle/pedestrian priority roadway)."
      )
    )
  ),
  transit_routes = list(
    name = "Train and Commuter Rail Routes (Including Silver Line)",
    layer_name = "transit_routes",
    sources = list(
      list(
        name="Massachusetts Bay Transportation Authority",
        url="https://www.mbta.com/developers/gtfs",
        year=lubridate::year(Sys.Date())
      )
    ),
    desc = "Train and commuter rail routes from the MBTA's [GTFS](https://gtfs.org/#) feed. Includes the Silver Line.",
    fields = list(
      list(
        name="route_id",
        desc="Unique identifier for a route."
      ),
      list(
        name="name",
        desc="Full name of a route."
      ),
      list(
        name="short_name",
        desc="Short name of a route, often more user-identifiable."
      ),
      list(
        name="desc",
        desc="Description of the route."
      )
    )
  ),
  transit_stops = list(
    name = "Train and Commuter Rail Stops (Including Silver Line)",
    layer_name = "transit_stops",
    sources = list(
      list(
        name="Massachusetts Bay Transportation Authority",
        url="https://www.mbta.com/developers/gtfs",
        year=lubridate::year(Sys.Date())
      )
    ),
    desc = "Train and commuter rail stops from the MBTA's [GTFS](https://gtfs.org/#) feed. Includes the Silver Line.",
    fields = list(
      list(
        name="id",
        desc="Unique identifier for a stop."
      ),
      list(
        name="name",
        desc="Name of a stop."
      )
    )
  ),
  watershed = list(
    name = "Charles River Watershed Boundary",
    layer_name = "charles_river_watershed",
    sources = list(
      list(
        name="USGS Watershed Boundary Dataset",
        url="https://www.usgs.gov/national-hydrography/watershed-boundary-dataset",
        year=2022
      )
    ),
    desc = 'Watersheds based on 12-digit hydrologic units, which represent the area of the landscape that drains to a portion of the stream network.',
    fields = list(
      list(
        name="id",
        desc="Unique identifier."
      ), 
      list(
        name="name",
        desc="Name of watershed."
      )
    )
  )
)

# NY ====

NY_META <- list(
  boroughs = list(
    name = "Boroughs",
    layer_name = "boroughs",
    sources = list(
      list(
        name="NYC Open Data",
        url="https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data",
        year=2024
      )
    ),
    desc = 'Boundaries of boroughs with water areas excluded.',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Borough name."
      )
    )
  ),
  openspace = list(
    name = "Parks Properties",
    layer_name = "openspace",
    sources = list(
      list(
        name="NYC Open Data",
        url="https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data",
        year=2024
      )
    ),
    desc = 'According to NYC open data, "identifies property managed partially or solely by NYC Parks"',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="name", 
        desc="Site name."
      ), 
      list(
        name="borough", 
        desc="Which NYC borough the site is in."
      )
    )
  ),
  cso_drainage = list(
    name = "CSO Drainage Areas",
    layer_name = "cso_drainage",
    sources = list(
      list(
        name="Open Sewer Atlas NYC",
        url="https://openseweratlas.tumblr.com/data",
        year=2019
      )
    ),
    desc = 'The drainage area associated with CSO outfalls',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="outfall", 
        desc="Outfall name."
      )
    )
  ),
  bike_facilities = list(
    name = "Bike Facilities",
    layer_name = "bike_facilities",
    sources = list(
      list(
        name="NYC Open Data",
        url="https://data.cityofnewyork.us/dataset/New-York-City-Bike-Routes-Map-/9e2b-mctv",
        year=2024
      )
    ),
    desc = 'According to NYC open data, "contains records of the current... network of designated bicycle routes and facilities.',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="street", 
        desc="Name of street on which facility segment lies."
      )
    )
  ),
  munis = list(
    name = "Municipalities (New York and Adjacent States)",
    layer_name = "munis",
    sources = list(
      list(
        name="New York State GIS Clearinghouse",
        url="https://gis.ny.gov/civil-boundaries",
        year=2024
      ),
      list(
        name="New Jersey Office of GIS",
        url="https://arc-gis-hub-home-arcgishub.hub.arcgis.com/datasets/newjersey::municipal-boundaries-of-nj/explore?location=39.788059%2C-74.706072%2C8.64",
        year=2024
      ),
      list(
        name="Connecticut Department of Energy & Environmental Protection",
        url="https://deepmaps.ct.gov/maps/82672ae5f3764021b9a4804f524f928b/about",
        year=2023
      )
    ),
    desc = 'Municipal boundaries for New York, New Jersey, and Connecticut.',
    fields = list(
      list(
        name="name", 
        desc="Name of municipality."
      ), 
      list(
        name="state", 
        desc="2-character state abbreviation."
      )
    )
  ),
  parcels = list(
    name = "Parcels",
    layer_name = "bronx_parcels",
    sources = list(
      list(
        name="NYC Planning PLUTO/MapPLUTO",
        url="https://www.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page",
        year=2024
      )
    ),
    desc = 'Parcel (tax lot) boundaries for the Bronx.',
    fields = list(
      list(
        name="bbl",
        desc="Unique identifier."
      )
    )
  ),
  assess = list(
    name = "Assessors' Tables",
    layer_name = "bronx_assess",
    sources = list(
      list(
        name="NYC Planning PLUTO/MapPLUTO",
        url="https://www.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page",
        year=2024
      )
    ),
    desc = 'Parcel (tax lot) attributes for the Bronx.',
    fields = list(
      list(
        name="bbl",
        desc="Unique identifier of parcel, used for joining."
      ),
      list(
        name="landuse",
        desc=""
      ),
      list(
        name="bldgclass",
        desc=""
      ),
      list(
        name="addr",
        desc="Parcel address."
      ),
      list(
        name="zip",
        desc="Parcel ZIP code."
      ),
      list(
        name="owner",
        desc="Owner name."
      ),
      list(
        name="bld_area",
        desc="Building area on parcel."
      ),
      list(
        name="city",
        desc="Residential area on parcel."
      ),
      list(
        name="units",
        desc="Unit count on parcel."
      ),
      list(
        name="lnd_val",
        desc="Assessed value of land."
      ),
      list(
        name="bld_val",
        desc="Assessed value of building."
      ),
      list(
        name="year_built",
        desc="Year building built."
      )
    )
  ),
  buildings = list(
    name = "Building Footprints",
    layer_name = "buildings",
    sources = list(
      list(
        name="NYC Open Data",
        url="https://data.cityofnewyork.us/Housing-Development/Building-Footprints/nqwf-w8eh",
        year=2024
      )
    ),
    desc = 'Building footprints in New York City.',
    fields = list(
      list(
        name="id", 
        desc="Unique identifier."
      ), 
      list(
        name="height", 
        desc="Height in feet."
      )
    )
  ),
  transit_routes = list(
    name = "Subway Routes",
    layer_name = "transit_routes",
    sources = list(
      list(
        name="Metropolitan Transit Authority (MTA)",
        url="https://new.mta.info/developers",
        year=lubridate::year(Sys.Date())
      )
    ),
    desc = "Subway routes drawn from the MTA's [GTFS](https://gtfs.org/#) feed.",
    fields = list(
      list(
        name="route_id",
        desc="Unique identifier for a route."
      ),
      list(
        name="name",
        desc="Full name of a route."
      ),
      list(
        name="short_name",
        desc="Short name of a route, often more user-identifiable."
      ),
      list(
        name="desc",
        desc="Description of the route."
      )
    )
  ),
  transit_stops = list(
    name = "Subway Stops",
    layer_name = "transit_stops",
    sources = list(
      list(
        name="Metropolitan Transit Authority (MTA)",
        url="https://new.mta.info/developers",
        year=lubridate::year(Sys.Date())
      )
    ),
    desc = "Subway stops drawn from the MTA's [GTFS](https://gtfs.org/#) feed.",
    fields = list(
      list(
        name="id",
        desc="Unique identifier for a stop."
      ),
      list(
        name="name",
        desc="Name of a stop."
      )
    )
  ),
  watershed = list(
    name = "Bronx River Watershed Boundary",
    layer_name = "bronx_river_watershed",
    sources = list(
      list(
        name="USGS Watershed Boundary Dataset",
        url="https://www.usgs.gov/national-hydrography/watershed-boundary-dataset",
        year=2022
      )
    ),
    desc = 'Watersheds based on 12-digit hydrologic units, which represent the area of the landscape that drains to a portion of the stream network.',
    fields = list(
      list(
        name="id",
        desc="Unique identifier."
      ), 
      list(
        name="name",
        desc="Name of watershed."
      )
    )
  )
)

# Natural Earth ====

NE_URL <- "https://www.naturalearthdata.com/downloads"
CULTURAL_URL <- glue::glue("{NE_URL}/{NE_SCALE}m-cultural-vectors")
PHYSICAL_URL <- glue::glue("{NE_URL}/{NE_SCALE}m-physical-vectors")



GRATICULE_LIST <- list()
for (int in GRATICULE_INTERVALS) {
  GRATICULE_LIST[[stringr::str_c("graticules", int, sep="_")]] <- list(
    name = glue::glue("{int}° Graticules"),
    layer_name = glue::glue("graticules_{int}"),
    sources = list(
      list(
        name="Eric Robsky Huntley",
        url="mit-spatial-action.github.io",
        year=2024
      )
    ),
    desc = glue::glue("A grid of latitude/longitude lines spaced by {int}°."),
    fields = NULL
  )
}

NE_META <- list(
  cultural = list(
     admin_0_countries = list(
      name = "Countries",
      layer_name = "countries",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{CULTURAL_URL}/{NE_SCALE}m-admin-0-countries"),
          year=2022
        )
      ),
      desc = 'Soviereign states, though Natural Earth shows whay they call "_de facto_ boundaries"---who controls the territory---versus _de jure_.',
      fields = list(
        list(
          name="sovereign", 
          desc="Sovereign state name."
        ), 
        list(
          name="admin", 
          desc="Name of administering authority."
        ), 
        list(
          name="name", 
          desc="Formal name of country."
        )
      )
    )
  ),
  physical = list(
    land = list(
      name = "Land",
      layer_name = "land",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{PHYSICAL_URL}/{NE_SCALE}m-land"),
          year=2022
        )
      ),
      desc = 'From NE: Derived from 10m coastline. Continental polygons broken into smaller, contiguous pieces to avoid having too many points in any one polygon, facilitating faster data processing in certain software applications.',
      fields = NULL
    ),
    lakes = list(
      name = "Lakes",
      layer_name = "lakes",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{PHYSICAL_URL}/{NE_SCALE}m-lakes"),
          year=2022
        )
      ),
      desc = 'From NE: Generalized from 10 million lakes theme. The 10 million lakes primarily derive from World Data Bank 2 with numerous reservoir additions from imagery sources. Diminishing areal extent of Aral Sea and Lake Chad was digitized from recent satellite imagery.',
      fields = list(
        list(
          name="name", 
          desc="Name of lake."
        ), 
        list(
          name="name_alt", 
          desc="Alternate name of lake."
        )
      )
    ),
    playas = list(
      name = "Playas",
      layer_name = "playas",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{PHYSICAL_URL}/{NE_SCALE}m-playas"),
          year=2022
        )
      ),
      desc = 'Playas---large, occasionally flooded flats in deserts---and salt pans---ground covered with salt in deserts caused by evaporation of water.',
      fields = list(
        list(
          name="name", 
          desc="Name of playa."
        ), 
        list(
          name="name_alt", 
          desc="Alternate name of playa."
        )
      )
    ),
    glaciated_areas = list(
      name = "Glaciated Areas",
      layer_name = "glaciated_areas",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{PHYSICAL_URL}/{NE_SCALE}m-glaciated-areas"),
          year=2022
        )
      ),
      desc = 'Glaciers and recently de-glaciated areas.',
      fields = NULL
    ),
    rivers_lake_centerlines = list(
      name = "Rivers, Lake Centerlines",
      layer_name = "rivers_lake_centerlines",
      sources = list(
        list(
          name="Natural Earth",
          url=glue::glue("{PHYSICAL_URL}/{NE_SCALE}m-rivers-lake-centerlines"),
          year=2022
        )
      ),
      desc = 'Linear drainages and lake centerlines.',
      fields = list(
        list(
          name="name", 
          desc="Name of river or lake."
        ),
        list(
          name="type", 
          desc="Water body type."
        )
      )
    )
  ),
  other = c(
    GRATICULE_LIST,
    list(
      bounding_box = list(
        name = "Bounding Box",
        layer_name = "bounding_box",
        sources = list(
          list(
            name="Eric Robsky Huntley",
            url="mit-spatial-action.github.io",
            year=2024
          )
        ),
        desc = 'A bounding box extending from -180° to 180° longitude and -90° to 90° latitude.',
        fields = NULL
      ),
      tissot = list(
        name = "Tissot's Indicatrix",
        layer_name = "tissot",
        sources = list(
          list(
            name="Eric Robsky Huntley",
            url="mit-spatial-action.github.io",
            year=2024
          )
        ),
        desc = "Tissot's indicatrix circles.",
        fields = NULL
      )
    )
  )
)
