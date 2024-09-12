# Supplementary Data Dictionary

## Charles River Watershed Boundary (`charles_river_watershed`) — 🌏

### [USGS Watershed Boundary Dataset](https://www.usgs.gov/national-hydrography/watershed-boundary-dataset) (2022)

Watersheds based on 12-digit hydrologic units, which represent the area of the landscape that drains to a portion of the stream network.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of watershed. |

### Geometry

| Type | CRS |
| --- | --- |
| POLYGON | [EPSG:2249](https://epsg.io/2249) |

`Downloaded at 2024-09-09 09:51:59.792856 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Bronx River Watershed Boundary (`bronx_river_watershed`) — 🌏

### [USGS Watershed Boundary Dataset](https://www.usgs.gov/national-hydrography/watershed-boundary-dataset) (2022)

Watersheds based on 12-digit hydrologic units, which represent the area of the landscape that drains to a portion of the stream network.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | character | Unique identifier. |
| `name` | character | Name of watershed. |

### Geometry

| Type | CRS |
| --- | --- |
| POLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-09 09:52:00.39618 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## CSO Drainage Areas (`cso_drainage`) — 🌏

### [Open Sewer Atlas NYC](https://openseweratlas.tumblr.com/data) (2019)

The drainage area associated with CSO outfalls

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `id` | integer | Unique identifier. |
| `outfall` | character | Outfall name. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-09 09:52:02.725076 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Assessors' Tables (`bronx_assess`)

### [NYC Planning PLUTO/MapPLUTO](https://www.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page) (2024)

Parcel (tax lot) attributes for the Bronx.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `bbl` | numeric | Unique identifier of parcel, used for joining. |
| `landuse` | character |  |
| `bldgclass` | character |  |
| `addr` | character | Parcel address. |
| `zip` | numeric | Parcel ZIP code. |
| `owner` | character | Owner name. |
| `bld_area` | numeric | Building area on parcel. |
| `city` | NULL | Residential area on parcel. |
| `units` | numeric | Unit count on parcel. |
| `lnd_val` | numeric | Assessed value of land. |
| `bld_val` | numeric | Assessed value of building. |
| `year_built` | integer | Year building built. |

`Downloaded at 2024-09-09 09:52:44.09742 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Parcels (`bronx_parcels`) — 🌏

### [NYC Planning PLUTO/MapPLUTO](https://www.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page) (2024)

Parcel (tax lot) boundaries for the Bronx.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `bbl` | numeric | Unique identifier. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-09 09:52:44.12106 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Assessors' Tables (`camberville_assess`)

### 

Standardized database information from Cambridge and Somerville assessors.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `loc_id` | character | Unique identifier of parcel, used for joining. |
| `bld_val` | numeric | Assessed value of building. |
| `lnd_val` | numeric | Assessed value of land. |
| `year` | integer | Fiscal year of record. |
| `ls_date` | character | Last sale date. |
| `ls_price` | numeric | Last sale price. |
| `use_code` | character | Use code, broadly consistent with MA [Property Type Classification Codes](https://www.mass.gov/doc/property-type-classification-codes-non-arms-length-codes-and-sales-report-spreadsheet/download). |
| `use_gen` | numeric | Generalized land use code, created by teaching team. |
| `addr` | character | Property address. |
| `city` | character | Property city. |
| `zip` | character | Property ZIP code. |
| `owner` | character | Owner name. |
| `year_built` | integer | Year building was built. |
| `units` | integer | Number of units---often quite incomplete. |
| `bld_area` | numeric | Building area. |
| `res_area` | numeric | Residential area in building. |

`Downloaded at 2024-09-09 09:52:52.540961 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Parcels (`camberville_parcels`) — 🌏

### 

Standardized assessors parcels containing property boundaries for Cambridge and Somerville.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `loc_id` | character | Unique identifier. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2249](https://epsg.io/2249) |

`Downloaded at 2024-09-09 09:52:52.562532 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Greater Boston Assorted Demographic Characteristics (`boston_demographics`) — 🌏

### [U.S. Census Bureau American Community Survey Estimates](https://www.census.gov/programs-surveys/acs/) (2017-2022)

Assorted demographic variables.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | Unique identifier for census geography. |
| `tot_lbr` | numeric | Total people aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301001). |
| `bik_lbr` | numeric | Bicycle commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301018). |
| `tst_lbr` | numeric | Transit commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301010). |
| `car_lbr` | numeric | Car commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301002). |
| `tot_clb` | numeric | Total people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025003). |
| `une_clb` | numeric | Unemployed aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025005). |
| `emp_clb` | numeric | Employed people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025004). |
| `tot_unt` | numeric | Total housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003001). |
| `rnt_unt` | numeric | Rented housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003003). |
| `own_unt` | numeric | Owner-occupied housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003002). |
| `tot_pop` | numeric | Total population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B01003001). |
| `wht_pop` | numeric | White population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002003). |
| `blk_pop` | numeric | Black population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002004). |
| `lat_pop` | numeric | Latine/Hispanic population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002012). |
| `ign_pop` | numeric | Indigenous population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002005). |
| `asn_pop` | numeric | Asian population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002006). |
| `hpi_pop` | numeric | Hawaiian/Pacific Islander population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002007). |
| `mlt_pop` | numeric | Multi-racial population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002009). |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2249](https://epsg.io/2249) |

`Downloaded at 2024-09-09 09:52:57.187962 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Bronx Assorted Demographic Characteristics (`bronx_demographics`) — 🌏

### [U.S. Census Bureau American Community Survey Estimates](https://www.census.gov/programs-surveys/acs/) (2017-2022)

Assorted demographic variables.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `geoid` | character | Unique identifier for census geography. |
| `tot_lbr` | numeric | Total people aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301001). |
| `bik_lbr` | numeric | Bicycle commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301018). |
| `tst_lbr` | numeric | Transit commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301010). |
| `car_lbr` | numeric | Car commuters aged 16+ in the labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B08301002). |
| `tot_clb` | numeric | Total people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025003). |
| `une_clb` | numeric | Unemployed aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025005). |
| `emp_clb` | numeric | Employed people aged 16+ in the _civilian_ labor force. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B23025004). |
| `tot_unt` | numeric | Total housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003001). |
| `rnt_unt` | numeric | Rented housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003003). |
| `own_unt` | numeric | Owner-occupied housing units. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B25003002). |
| `tot_pop` | numeric | Total population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B01003001). |
| `wht_pop` | numeric | White population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002003). |
| `blk_pop` | numeric | Black population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002004). |
| `lat_pop` | numeric | Latine/Hispanic population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002012). |
| `ign_pop` | numeric | Indigenous population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002005). |
| `asn_pop` | numeric | Asian population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002006). |
| `hpi_pop` | numeric | Hawaiian/Pacific Islander population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002007). |
| `mlt_pop` | numeric | Multi-racial population. See [Social Explorer Documentation](https://www.socialexplorer.com/data/ACS2022_5yr/metadata/?ds=ACS22_5yr&var=B03002009). |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:2263](https://epsg.io/2263) |

`Downloaded at 2024-09-09 09:53:05.304765 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


