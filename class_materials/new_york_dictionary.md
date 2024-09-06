# NY Data Dictionary

## Boroughs (`boroughs`) — 🌏

### [NYC Open Data](https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data) (2024)

Boundaries of boroughs with water areas excluded.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Borough name. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:07:50.696951 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Building Footprints (`buildings`) — 🌏

### [NYC Open Data](https://data.cityofnewyork.us/Housing-Development/Building-Footprints/nqwf-w8eh) (2024)

Building footprints in New York City.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `height` | character | Height in feet. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:10:15.944685 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Subway Routes (`transit_routes`) — 🌏

### [Metropolitan Transit Authority (MTA)](https://new.mta.info/developers) (2024)

Subway routes drawn from the MTA's [GTFS](https://gtfs.org/#) feed.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `route_id` | character | Unique identifier for a route. |
| `name` | character | Full name of a route. |
| `short_name` | character | Short name of a route, often more user-identifiable. |
| `desc` | character | Description of the route. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:10:22.057571 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Subway Stops (`transit_stops`) — 🌏

### [Metropolitan Transit Authority (MTA)](https://new.mta.info/developers) (2024)

Subway stops drawn from the MTA's [GTFS](https://gtfs.org/#) feed.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier for a stop. |
| `name` | character | Name of a stop. |

### Geometry

| Type | CRS |
| --- | --- |
| POINT | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:10:22.098603 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Parks Properties (`openspace`) — 🌏

### [NYC Open Data](https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data) (2024)

According to NYC open data, "identifies property managed partially or solely by NYC Parks"

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | numeric | Unique identifier. |
| `name` | NULL | Site name. |
| `borough` | NULL | Which NYC borough the site is in. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:10:24.315779 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Municipalities (New York and Adjacent States) (`munis`) — 🌏

### [New York State GIS Clearinghouse](https://gis.ny.gov/civil-boundaries) (2024), [New Jersey Office of GIS](https://arc-gis-hub-home-arcgishub.hub.arcgis.com/datasets/newjersey::municipal-boundaries-of-nj/explore?location=39.788059%2C-74.706072%2C8.64) (2024), [Connecticut Department of Energy & Environmental Protection](https://deepmaps.ct.gov/maps/82672ae5f3764021b9a4804f524f928b/about) (2023)

Municipal boundaries for New York, New Jersey, and Connecticut.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `name` | character | Name of municipality. |
| `state` | character | 2-character state abbreviation. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:10:24.887053 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Contour Lines (`contours`) — 🌏

### [U.S.G.S. 3D Elevation Program](https://www.usgs.gov/3d-elevation-program) (2010)

Contour lines spaced at 5-meter intervals.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | integer | Unique identifier. |
| `level` | character | Elevation in meters. |

### Geometry

| Type | CRS |
| --- | --- |
| LINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:06.192176 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Area Hydrography (`area_water`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the Census: The area hydrography shapefile contains the geometry and attributes of both perennial and intermittent area hydrography features, including ponds, lakes, oceans, swamps, glaciers, and the area covered by large streams represented as double-line drainage

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of water body. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:06.586279 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Linear Hydrography (`linear_water`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the US Census Bureau: 'The linear hydrography shapefile contains all linear features with 'H' (Hydrography) type MTFCCs in the MAF/TIGER database by county. The shapefiles are provided at a county geographic extent and in linear elemental feature geometry. The linear hydrography shapefile includes streams/rivers, braided streams, canals, ditches, artificial paths, and aqueducts. A linear hydrography feature may include edges with both perennial and intermittent persistence.'

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of water body. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:07.078282 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## All Roads (`roads`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the Census Bureau: "The content of the all roads shapefile includes primary roads, secondary roads, local neighborhood roads, rural roads, city streets, vehicular trails (4WD), ramps, service drives, walkways, stairways, alleys, and private roads."

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of road. |
| `type` | character | Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.) |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:12.737457 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## States and 'Equivalent Entities' (I.e., Territories) (`states`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

These are the 50 states of the US as well as DC and the U.S.'s territories and conquests (Puerto Rico, American Samoa, the Commonwealth of the Northern Mariana Islands, Guam, and the U.S. Virgin Islands). Only a small subset are included here for class purposes.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | 2-digit unique identifier. |
| `abbrev` | character | Two-character abbreviation of state name. |
| `name` | character | Long-form name of state. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:14.118382 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Primary Roads (`primary_roads`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the Census Bureau: "Primary roads are generally divided, limited-access highways within the Federal interstate highway system or under state management. These highways are distinguished by the presence of interchanges and are accessible by ramps and may include some toll highways."

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of road. |
| `type` | character | Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.) |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:16.371437 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Counties and Equivalent (`counties`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

These represent the primary legal divisons of the states. In most states, these are called counties (though, for example, Lousiana has 'parishes') and Alaska has no counties but a more complicated system of boroughs, cities, and areas.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | 5-digit unique county identifier. |
| `stateid` | character | 2-digit state identifier. |
| `countyid` | character | 3-digit county identifier. |
| `name` | character | Long-form name of county. |
| `state` | character | Two-character abbreviation of state name. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:17.601604 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Primary and Secondary Roads (`primary_secondary_roads`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the Census Bureau: "Primary roads are generally divided, limited-access highways within the Federal interstate highway system or under state management. These highways are distinguished by the presence of interchanges and are accessible by ramps and may include some toll highways. Secondary roads are main arteries, usually in the U.S. highway, state highway, or county highway system. These roads have one or more lanes of traffic in each direction, may or may not be divided, and usually have at-grade intersections with many other roads and driveways."

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of road. |
| `type` | character | Type of road. Possible values are C (county), I (interstate), M (Common Name), O (Other), S (State Recognized), U (U.S.) |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:18.715753 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Census Block Groups (`block_groups`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the US Census Bureau:Standard block groups are clusters of blocks within the same census tract that have the same first digit of their 4-character census block number. For example, blocks 3001, 3002, 3003..., 3999 in census tract 1210.02 belong to Block Group 3. Due to boundary and feature changes that occur throughout the decade, current block groups do not always maintain these same block number to block group relationships. For example, block 3001 might move due to a census tract boundary change but the block number will not change, even if it does not still fall in block group 3. However, the GEOID for that block, identifying block group 3, would remain the same in the attribute information in the TIGER/Line Shapefiles because block GEOIDs are always built using the decennial geographic codes."

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | 12-digit unique identifier for block group. |
| `stateid` | character | 2-digit unique identifier for state. |
| `countyid` | character | 3-digit unique identifier for county. |
| `tractid` | character | 6-digit unique identifier for census tract. |
| `bgid` | character | 1-digit unique identifier for block group. |
| `name` | character | Human-readable name. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:19.926408 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Census Tracts (`tracts`) — 🌏

### [US Census Bureau TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-geodatabase-file.html) (2022)

From the US Census Bureau: Census Tracts are small, relatively permanent statistical subdivisions of a county or equivalent entity that are updated by local participants prior to each decennial census as part of the... Participant Statistical Areas Program.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | 11-digit unique identifier for census group. |
| `stateid` | character | 2-digit unique identifier for state. |
| `countyid` | character | 3-digit unique identifier for county. |
| `tractid` | character | 6-digit unique identifier for census tract. |
| `name` | character | Human-readable name. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-06 17:11:20.525604 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


