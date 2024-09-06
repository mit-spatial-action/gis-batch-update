# Natural Earth Data Dictionary

## Countries (`countries`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries) (2022)

Soviereign states, though Natural Earth shows whay they call "_de facto_ boundaries"---who controls the territory---versus _de jure_.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `sovereign` | character | Sovereign state name. |
| `admin` | character | Name of administering authority. |
| `name` | character | Formal name of country. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:08.783947 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Land (`land`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-land) (2022)

From NE: Derived from 10m coastline. Continental polygons broken into smaller, contiguous pieces to avoid having too many points in any one polygon, facilitating faster data processing in certain software applications.

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:10.415549 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Lakes (`lakes`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-lakes) (2022)

From NE: Generalized from 10 million lakes theme. The 10 million lakes primarily derive from World Data Bank 2 with numerous reservoir additions from imagery sources. Diminishing areal extent of Aral Sea and Lake Chad was digitized from recent satellite imagery.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `name` | character | Name of lake. |
| `name_alt` | character | Alternate name of lake. |

### Geometry

| Type | CRS |
| --- | --- |
| POLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:11.103323 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Playas (`playas`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-playas) (2022)

Playas---large, occasionally flooded flats in deserts---and salt pans---ground covered with salt in deserts caused by evaporation of water.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `name` | character | Name of playa. |
| `name_alt` | character | Alternate name of playa. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTIPOLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:13.054128 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Glaciated Areas (`glaciated_areas`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-glaciated-areas) (2022)

Glaciers and recently de-glaciated areas.

### Geometry

| Type | CRS |
| --- | --- |
| POLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:13.607805 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Rivers, Lake Centerlines (`rivers_lake_centerlines`) — 🌏

### [Natural Earth](https://www.naturalearthdata.com/downloads/50m-physical-vectors/50m-rivers-lake-centerlines) (2022)

Linear drainages and lake centerlines.

### Fields
| Name | Type | Description |
| --- | --- | --- |
| `name` | character | Name of river or lake. |
| `type` | character | Water body type. |

### Geometry

| Type | CRS |
| --- | --- |
| MULTILINESTRING | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:14.93256 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## 15° Graticules (`graticules_15`) — 🌏

### [Eric Robsky Huntley](mit-spatial-action.github.io) (2024)

A grid of latitude/longitude lines spaced by 15°.

### Geometry

| Type | CRS |
| --- | --- |
| LINESTRING | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:14.954288 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## 30° Graticules (`graticules_30`) — 🌏

### [Eric Robsky Huntley](mit-spatial-action.github.io) (2024)

A grid of latitude/longitude lines spaced by 30°.

### Geometry

| Type | CRS |
| --- | --- |
| LINESTRING | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:14.974578 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Tissot's Indicatrix (`tissot`) — 🌏

### [Eric Robsky Huntley](mit-spatial-action.github.io) (2024)

Tissot's indicatrix circles.

### Geometry

| Type | CRS |
| --- | --- |
| POLYGON | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:15.341778 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


## Bounding Box (`bounding_box`) — 🌏

### [Eric Robsky Huntley](mit-spatial-action.github.io) (2024)

A bounding box extending from -180° to 180° longitude and -90° to 90° latitude.

### Geometry

| Type | CRS |
| --- | --- |
| LINESTRING | [EPSG:4326](https://epsg.io/4326) |

`Downloaded at 2024-09-06 12:08:15.351249 by ericrobskyhuntley on Erics-MacBook-Pro-2.local.`

---


