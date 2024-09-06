source('https://raw.githubusercontent.com/ographiesresearch/urbanplanR/main/R/globals.R')
source('https://raw.githubusercontent.com/ographiesresearch/urbanplanR/main/R/acs.R')
source("config.R")

# Spatial Helpers ====

st_clip <- function(x, y) {
  init_type <- as.character(sf::st_geometry_type(x, by_geometry=FALSE))
  clip <- x |>
    sf::st_set_agr("constant") |>
    sf::st_intersection(
      y |>
        sf::st_union() |>
        sf::st_geometry()
    ) |>
    dplyr::filter(
      as.character(sf::st_geometry_type(geometry)) %in% c(
        init_type, 
        stringr::str_c("MULTI", init_type, sep=""),
        stringr::str_remove(init_type, "MULTI")
      )
    )
  
  clip_type_multi <- base::any(
    stringr::str_detect(
      clip |>
        sf::st_geometry_type(by_geometry=TRUE) |>
        as.character() |>
        base::unique(), 
      "MULTI"
    )
  )
  
  init_type_multi <- stringr::str_detect(init_type, "MULTI")
  
  if (clip_type_multi & !init_type_multi) {
    cast_to <- stringr::str_c("MULTI", init_type, sep="")
  } else {
    cast_to <- init_type
  }
  
  clip |>
    sf::st_cast(cast_to)
}

# General Layers: Census ====

get_counties <- function(counties_list, crs, year) {
  counties <- list()
  for (state in names(counties_list)) {
    counties[[state]] <- tigris::counties(state=state, year=year, cb=TRUE) |>
      dplyr::filter(NAME %in% counties_list[[state]])
  }
  
  dplyr::bind_rows(counties) |> 
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      geoid,
      stateid = statefp,
      countyid = countyfp,
      name,
      state = stusps
    )
}

get_states <- function(state_list, crs, year) {
  tigris::states(year=year, cb = TRUE) |>
    dplyr::rename_with(tolower) |>
    dplyr::filter(stusps %in% state_list) |> 
    sf::st_transform(crs) |>
    dplyr::select(
      geoid,
      abbrev = stusps,
      name
    )
}

get_area_water <- function(counties_list, crs, year) {
  df <- list()
  for (state in names(counties_list)) {
    for (county in counties_list[[state]]) {
      df[[county]] <- tigris::area_water(state=state, county=county, year=year)
    }
  }
  dplyr::bind_rows(df) |> 
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = hydroid,
      name = fullname
    )
}

get_linear_water <- function(counties_list, crs, year) {
  df <- list()
  for (state in names(counties_list)) {
    for (county in counties_list[[state]]) {
      df[[county]] <- tigris::linear_water(state=state, county=county, year=year)
    }
  }
  dplyr::bind_rows(df) |> 
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = linearid,
      name = fullname
    )
}

get_roads <- function(counties_list, crs, year) {
  df <- list()
  for (state in names(counties_list)) {
    for (county in counties_list[[state]]) {
      df[[county]] <- tigris::roads(state=state, county=county, year=year)
    }
  }
  dplyr::bind_rows(df) |> 
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = linearid,
      name = fullname,
      type = rttyp
    )
}

get_primary_roads <- function(states, crs, year) {
  tigris::primary_roads(year=year) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    st_clip(
      states |>
        sf::st_geometry() |> 
        sf::st_union()
      ) |>
    dplyr::select(
      id = linearid,
      name = fullname,
      type = rttyp
    )
}

get_primary_secondary_roads <- function(counties_list, counties, crs, year) {
  df <- list()
  for (state in names(counties_list)) {
    df[[state]] <- tigris::primary_secondary_roads(state=state, year=year)
  }
  dplyr::bind_rows(df) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    st_clip(
      counties |> 
        sf::st_geometry() |> 
        sf::st_union()
      ) |>
    dplyr::select(
      id = linearid,
      name = fullname,
      type = rttyp
    )
}

get_block_groups <- function(state, crs, year) {
  tigris::block_groups(state=state, year=year, cb=TRUE) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      geoid,
      stateid = statefp,
      countyid = countyfp,
      tractid = tractce,
      bgid = blkgrpce,
      name = namelsad
    )
}

get_tracts <- function(state, crs, year) {
  tigris::tracts(state=state, year=year, cb=TRUE) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      geoid,
      stateid = statefp,
      countyid = countyfp,
      tractid = tractce,
      name = namelsad
    )
}
  
get_demographics <- function(geography, state, year, crs) {
  vars <- c(
    "tot_lbr" = "B08301_001",
    "bik_lbr" = "B08301_018",
    "tst_lbr" = "B08301_010",
    "car_lbr" = "B08301_002",
    "tot_clb" = "B23025_003",
    "une_clb" = "B23025_005",
    "emp_clb" = "B23025_004",
    "tot_unt" = "B25003_001",
    "rnt_unt" = "B25003_003",
    "own_unt" = "B25003_002",
    "tot_pop" = "B01003_001",
    "wht_pop" = "B03002_003",
    "blk_pop" = "B03002_004",
    "lat_pop" = "B03002_012",
    "ign_pop" = "B03002_005",
    "asn_pop" = "B03002_006",
    "hpi_pop" = "B03002_007",
    "mlt_pop" = "B03002_009"
  )
  get_acs_vars(
    vars, 
    states = state,
    year = year,
    census_unit = geography,
    geometry = TRUE
    ) |>
    sf::st_transform(crs) |>
    dplyr::rename(
      geoid=unit_id
    )
}
  
# General Layers: Other ====

get_watershed <- function(point, crs) {
  watershed <- nhdplusTools::get_huc(
    AOI=point, 
    type="huc12"
  ) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = huc12,
      name
    )
}

get_transit <- function(agency, crs) {
  if (agency=="MTA") {
    gtfs <- tidytransit::read_gtfs("http://web.mta.info/developers/data/nyct/subway/google_transit.zip")
    route_ids <- gtfs$routes$route_id
    place_meta <- NY_META
  } else if (agency=="MBTA") {
    gtfs <- tidytransit::read_gtfs("https://cdn.mbta.com/MBTA_GTFS.zip")
    route_ids=gtfs$routes |>
      dplyr::filter(
        route_desc %in% c("Rapid Transit", "Commuter Rail") |
          stringr::str_detect(route_short_name, "^SL")) |>
      dplyr::pull(route_id)
    place_meta <- MA_META
  }
  gtfs <- gtfs |>
    tidytransit::empty_strings_to_na()
  
  gtfs$stops <- gtfs$stops  |> 
    tidyr::drop_na(stop_lat, stop_lon)
  
  routes <- gtfs |>
    tidytransit::gtfs_as_sf() |>
    tidytransit::get_route_geometry(
      route_ids=route_ids
    ) |>
    dplyr::left_join(
      gtfs$routes |>
        dplyr::select(
          route_id,
          desc = route_desc,
          name = route_long_name,
          short_name = route_short_name
        ),
      by=dplyr::join_by(route_id)
    ) |>
    sf::st_transform(crs)
  
  gtfs$stops <- gtfs |>
    tidytransit::filter_stops(
      service_ids=gtfs$calendar$service_id,
      route_ids=route_ids
    )
  
  stops <- gtfs$stops |>
    tidytransit::stops_as_sf() |>
    dplyr::group_by(stop_name) |>
    dplyr::slice_head(n=1) |>
    dplyr::ungroup() |>
    dplyr::select(
      id = stop_id,
      name = stop_name
    )  |>
    sf::st_transform(crs)
  list(
    routes=routes, 
    stops=stops
  )
}

get_contours <- function(
    areas, 
    crs,
    filter_thresh = units::set_units(250, m)
) {
  dem <- elevatr::get_elev_raster(
    locations = sf::st_transform(sf::st_as_sf(areas), 4326),
    z = 14,
    clip = "locations"
  ) |>
    raster::reclassify(cbind(-Inf, 0, 0), right = FALSE)
  
  levels <- base::seq(
    from = base::floor(raster::minValue(dem)),
    to = base::ceiling(raster::maxValue(dem)),
    by = 5
  )
  
  dem |>
    raster::rasterToContour(
      levels = levels
    ) |>
    sf::st_as_sf() |>
    sf::st_transform(crs) |>
    sf::st_set_agr("constant") |>
    sf::st_cast("LINESTRING") |>
    dplyr::mutate(
      length = sf::st_length(geometry)
    ) |>
    dplyr::filter(
      length > filter_thresh
    ) |>
    dplyr::select(-length) |>
    tibble::rowid_to_column("id")
}

# MA Layers ====

get_ma_openspace <- function(crs) {
  get_shp_from_remote_zip(
    "https://s3.us-east-1.amazonaws.com/download.massgis.digital.mass.gov/shapefiles/state/openspace.zip",
    shpfile="OPENSPACE_POLY.shp",
    crs=crs
  ) |>
    dplyr::rename_with(tolower) |>
    tibble::rowid_to_column("id") |>
    dplyr::select(
      id,
      name=site_name,
      owner=fee_owner,
      owner_type
    )
}


get_ma_munis <- function(crs) {
  get_from_arc("43664de869ca4b06a322c429473c65e5_0", crs = crs) |>
    dplyr::mutate(
      town = stringr::str_to_title(town),
      state = "MA"
    ) |>
    dplyr::select(
      name = town, 
      state
    )
}

get_ma_parcels <- function(muni_ids, crs) {
  muni_list <- readr::read_csv('https://raw.githubusercontent.com/mit-spatial-action/who-owns-mass-processing/main/data/muni_ids.csv')
  parcels <- list()
  assess <- list()
  for (id in muni_ids) {
    muni_name <- muni_list |> 
      dplyr::filter(muni_id == id) |> 
      dplyr::pull(muni) |> 
      base::as.character()
    url <- glue::glue("http://download.massgis.digital.mass.gov/shapefiles/l3parcels/L3_SHP_M{id}_{muni_name}.zip")
    temp <- base::tempfile(fileext = ".zip")
    get_remote_zip(
      url = url,
      path = temp
    )
    files <- unzip(temp, list = TRUE)
    parcels[[id]] <- read_shp_from_zip(
      temp, 
      files |>
        dplyr::filter(
          stringr::str_detect(
            Name, 
            glue::glue("M{id}TaxPar_.*\\.shp$")
            )
          ) |>
        dplyr::pull(Name)
      )
    assess[[id]] <- read_shp_from_zip(
      temp, 
      files |>
        dplyr::filter(
          stringr::str_detect(
            Name, 
            glue::glue("M{id}Assess_.*\\.dbf$"))
          ) |>
        dplyr::pull(Name)
    )
  }
  parcels <- dplyr::bind_rows(parcels) |>
    sf::st_transform(crs) |>
    dplyr::rename_with(tolower) |>
    dplyr::select(
      loc_id
    )
  
  assess <- dplyr::bind_rows(assess) |>
    dplyr::rename_with(tolower) |>
    dplyr::left_join(
      readr::read_csv("data/crosswalk.csv"),
      by=dplyr::join_by(use_code)
    ) |>
    dplyr::filter(!is.na(use_gen)) |>
    dplyr::group_by(loc_id) |> 
    dplyr::slice_head(n=1) |>
    dplyr::ungroup() |>
    dplyr::select(
      loc_id,
      bld_val = bldg_val,
      lnd_val = land_val,
      year = fy,
      ls_date,
      ls_price,
      use_code,
      use_gen,
      addr = site_addr,
      city,
      zip,
      owner = owner1,
      year_built,
      units,
      bld_area,
      res_area,
    )
  
  min_year <- min(assess$year)
  max_year <- max(assess$year)
  
  if(min_year == max_year) {
    year <- as.character(max_year)
  } else {
    year <- stringr::str_c(min_year, max_year, sep="-")
  }
  MA_META$parcels$sources[[1]]$year <- year
  MA_META$assess$sources[[1]]$year <- year
  list(
    parcels = parcels,
    assess = assess
  )
}

get_ma_buildings <- function(muni_ids, crs) {
  buildings <- list()
  for (id in muni_ids) {
    id <- as.integer(id)
    url <- glue::glue(
      "https://s3.us-east-1.amazonaws.com/download.massgis.digital.mass.gov/shapefiles/structures/structures_poly_{id}.zip"
    )
    buildings[[id]] <- get_shp_from_remote_zip(
        url,
        shpfile=glue::glue("structures_poly_{id}.shp"),
        crs=crs
      )
  }
  dplyr::bind_rows(buildings) |>
    dplyr::select(
      -dplyr::everything()
    )
}

get_ma_bikefac <- function(crs) {
  get_shp_from_remote_zip(
      "https://s3.us-east-1.amazonaws.com/download.massgis.digital.mass.gov/shapefiles/state/biketrails_arc.zip",
      shpfile="biketrails_arc/BIKETRAILS_ARC.shp",
      crs=crs
    ) |>
    tibble::rowid_to_column("id") |>
    dplyr::select(
      id,
      type=fac_type_n,
      name=local_name
    ) |>
    sf::st_zm() |>
    sf::st_transform(crs)
}



# NY Layers ====

get_nyc_openspace <- function(crs) {
  sf::st_read(
      "https://nycopendata.socrata.com/api/geospatial/enfh-gkve?fourfour=enfh-gkve&accessType=DOWNLOAD&method=export&format=GeoJSON", 
      drivers="geojson"
    ) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |> 
    dplyr::select(
      id = globalid,
      name = signname,
      borough
    )
}

get_nyc_boroughs <- function(crs) {
  sf::st_read(
    "https://data.cityofnewyork.us/api/geospatial/tqmj-j8zm?method=export&format=GeoJSON", 
    drivers="geojson"
  ) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = boro_code,
      name = boro_name
    )
}

get_nyc_buildings <- function(crs) {
  sf::st_read(
    "https://data.cityofnewyork.us/api/geospatial/qb5r-6dgf?method=export&format=GeoJSON", 
    drivers="geojson"
  ) |>
    dplyr::filter(stringr::str_starts(base_bbl, "2")) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      id = globalid,
      height = heightroof
    )
}

get_ny_munis <- function(crs) {
  get_shp_from_remote_zip(
    "https://gisdata.ny.gov/GISData/State/Civil_Boundaries/NYS_Civil_Boundaries.shp.zip",
    shpfile="Cities_Towns.shp",
    crs=crs
  ) |>
    dplyr::select(
      name
    ) |>
    dplyr::mutate(state = "NY")
}

get_nj_munis <- function(crs) {
  url <- httr::parse_url("https://services2.arcgis.com/XVOqAjTOJ5P6ngMu/ArcGIS/rest/services")
  url$path <- paste(url$path, "NJ_Municipal_Boundaries_3424/FeatureServer/0/query", sep = "/")
  url$query <- list(where = "POPDEN2020>0",
                    outFields = "*",
                    returnGeometry = "true",
                    f = "geojson")
  request <- httr::build_url(url)
  
  sf::st_read(request) |>
    dplyr::rename_with(tolower) |>
    sf::st_transform(crs) |>
    dplyr::select(
      name
    ) |>
    dplyr::mutate(state = "NJ")
}

get_ny_adjacent_munis <- function(crs) {
  dplyr::bind_rows(
    get_ct_munis(crs) |>
      dplyr::select(
        name = pl_name,
        state
      ),
    get_ny_munis(crs),
    get_nj_munis(crs)
    )
}

get_nyc_bikefac <- function(crs) {
  readr::read_csv("https://data.cityofnewyork.us/api/views/mzxg-pwib/rows.csv?date=20240905&accessType=DOWNLOAD")|>
    dplyr::filter(status == "Current") |>
    dplyr::select(id=segmentid, geometry=the_geom, street) |>
    sf::st_as_sf(wkt="geometry", crs=4326) |>
    sf::st_transform(crs)
}

get_nyc_parcels <- function(crs, pluto_version=PLUTO_VERSION) {
  df <- get_shp_from_remote_zip(
    glue::glue("https://s-media.nyc.gov/agencies/dcp/assets/files/zip/data-tools/bytes/nyc_mappluto_{pluto_version}_shp.zip"),
    shpfile="MapPLUTO.shp",
    crs=crs
  ) |>
  dplyr::filter(stringr::str_starts(bbl, "2"))
  
  parcels <- df |>
    dplyr::select(
      bbl
    )
  
  assess <- df|>
    sf::st_drop_geometry() |>
    dplyr::select(
      bbl,
      landuse,
      bldgclass,
      addr = address,
      borough = borough,
      zip = zipcode,
      owner = ownername,
      bld_area = bldgarea,
      res_area = resarea,
      units = unitstotal,
      lnd_val = assessland,
      tot_val = assesstot,
      year_built = yearbuilt
    ) |>
    dplyr::filter(borough == "BX") |>
    dplyr::mutate(
      year = as.numeric(stringr::str_extract(pluto_version, "^[0-9]+")) + 2000,
      bld_val = tot_val - lnd_val
    ) |>
    dplyr::select(-c(tot_val))
  
  list(
    parcels = parcels,
    assess = assess
  )
}

get_nyc_cso <- function(crs, csos=NYC_CSOS) {
  get_shp_from_remote_zip(
    "https://drive.usercontent.google.com/download?id=0B4wX_nnTabwhTkNab3NUNjVyRjQ&export=download&authuser=0&resourcekey=0-M0_6EiKedv2gHoJEPqvMdQ",
    shpfile="combinedsewer_drainage_area.shp",
    crs=crs
  ) |>
    dplyr::rename_with(tolower) |>
    tibble::rowid_to_column("id") |>
    dplyr::filter(
      outfall %in% csos
    ) |>
    dplyr::select(
      id,
      outfall
    )
}

# Natural Earth Helpers ====

graticule_by <- function(by) {
  sf::st_graticule(lon = seq(-180.0, 180.0, by = by), lat = seq(-90.0, 90.0, by = by))
}

build_bbox <- function(crs) {
  sf::st_linestring(matrix(c(-180, -90, -180, 90, 180, 90, 180, -90, -180, -90), ncol = 2, byrow=TRUE)) |>
    sf::st_sfc() |>
    sf::st_set_crs(4326) |>
    sf::st_as_sf() |>
    sf::st_transform(crs)  |>
    sf::st_set_geometry("geometry")
}

build_tissot <- function(graticules, miles=200) {
  sf::st_intersection(
    graticules |>
      dplyr::filter(type=="E" & !(abs(degree) %in% c(180))) |>
      dplyr::select(-dplyr::everything()),
    graticules |>
      dplyr::filter(type=="N" & !(abs(degree) %in% c(90))) |>
      dplyr::select(-dplyr::everything())) |>
    sf::st_buffer(dist = units::set_units(miles, "miles"))
}

# Show-Runners ====

write_meta <- function(df, meta, file) {
  sources <- c()
  for (source in meta$sources) {
    sources <- c(sources, glue::glue("[{source$name}]({source$url}) ({source$year})"))
  }
  sources <- stringr::str_c(sources, collapse=", ")
  if (!is.null(meta$fields)) {
    fields <- c(
      "### Fields",
      "| Name | Type | Description |",
      "| --- | --- | --- |"
    )
    for (field in meta$fields) {
      fields <- c(fields, glue::glue("| `{field$name}` | {class(df[[field$name]])} | {field$desc} |"))
    }
    fields <- stringr::str_c(fields, collapse="\n")
  } else {
    fields <- c()
  }
  meta$name <- stringr::str_c(meta$name, " (`", meta$layer_name, "`)")
  if ("sf" %in% class(df)) {
    meta$name <- stringr::str_c(meta$name, " — 🌏")
  }
  text <- c(
    glue::glue("## {meta$name}"),
    glue::glue("### {sources}"),
    glue::glue("{meta$desc}"),
    fields
  )
  if ("sf" %in% class(df)) {
    type <- as.character(sf::st_geometry_type(df, by_geometry=FALSE))
    epsg <- sf::st_crs(df)$input
    epsg_num <- stringr::str_extract(epsg, "[0-9]+$")
    geo <- c(
      "| Type | CRS |",
      "| --- | --- |",
      glue::glue("| {type} | [{epsg}](https://epsg.io/{epsg_num}) |")
    )
    geo <- stringr::str_c(geo, collapse="\n")
    text <- c(
      text,
      "### Geometry",
      geo
    )
  }
  text <- c(
    text,
    glue::glue("`Downloaded at {Sys.time()} by {Sys.info()[['user']]} on {Sys.info()[['nodename']]}.`"),
    "---",
    ""
  )
  base::writeLines(stringr::str_c(text, collapse="\n\n"), file)
  df
}

create_dir <- function(path, name=NULL) {
  if (!is.null(name)) {
    dir_path <- file.path(path, name)
  } else {
    dir_path <- file.path(path)
  }
  if(!dir.exists(dir_path)) {
    dir.create(dir_path)
  } else {
    message(glue::glue("{dir_path} exists. Skipping."))
  }
}

create_dirs <- function(path) {
  message("Creating directory structure...")
  create_dir(path)
  
  create_dir(file.path(path, "basedata"))
  
  labs <- seq(1,7)
  lab_path <- file.path(path, "labs")
  create_dir(lab_path)
  for (lab in labs) {
    create_dir(lab_path, glue::glue("lab{lab}"))
    create_dir(lab_path, file.path(glue::glue("lab{lab}"), "data"))
  }
  exs <- seq(1,3)
  ex_path <- file.path(path, "exercises")
  create_dir(ex_path)
  for (ex in exs) {
    create_dir(ex_path, glue::glue("exercise{ex}"))
    create_dir(lab_path, file.path(glue::glue("lab{lab}"), "data"))
  }
}

get_naturalearth_data <- function(base_path, out_dir, gpkg, meta_file, crs, scale, graticule_intervals) {
  
  gpkg_path <- base::file.path(base_path, out_dir, gpkg)
  meta_path <- base::file.path(base_path, out_dir, meta_file)
  
  if (base::file.exists(meta_path)) {
    base::file.remove(meta_path)
  }
  
  meta_file <- base::file(
    description=meta_path, 
    open="at"
    )
  base::on.exit(base::close(meta_file))
  
  base::writeLines(glue::glue("# Natural Earth Data Dictionary\n\n"), meta_file)
  
  for (category in base::names(NE_META[c('cultural', 'physical')])) {
    for (layer in names(NE_META[[category]])) {
      rnaturalearth::ne_download(
          scale=scale, 
          type=layer, 
          category=category
          ) |>
        dplyr::rename_with(base::tolower) |>
        sf::st_transform(crs) |>
        dplyr::select(
          dplyr::any_of(
            c(
              sovereign="sovereignt", 
              admin="admin",
              name="name", 
              name_alt="name_alt", 
              type="featurecla"
              )
          )
        ) |>
        sf::st_write(
          gpkg_path, 
          layer=NE_META[[category]][[layer]]$layer_name, 
          delete_layer = TRUE
        ) |>
        write_meta(NE_META[[category]][[layer]], meta_file)
    }
  }
  
  tissot_interval <- max(graticule_intervals)
  
  for (int in graticule_intervals) {
    int_name <- glue::glue("graticules_{int}")
    graticule <- graticule_by(int) |>
      sf::st_transform(crs) |>
      sf::st_write(
        dsn=gpkg_path, 
        layer=int_name, 
        delete_layer=TRUE
        ) |>
      write_meta(NE_META$other[[int_name]], meta_file)
    if (int == tissot_interval) {
      build_tissot(graticule) |>
        sf::st_write(
          dsn=gpkg_path, 
          layer=NE_META$other$tissot$layer_name, 
          delete_layer=TRUE
        ) |>
        write_meta(NE_META$other$tissot, meta_file)
    }
  }
  
  build_bbox(
    crs=crs
    ) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=NE_META$other$bounding_box$layer_name, 
      delete_layer=TRUE
    ) |>
    write_meta(NE_META$other$bounding_box, meta_file)
  return(invisible(NULL))
}

get_base_data <- function(state, base_path, out_dir, gpkg, crs, year, meta_file) {
  gpkg_path <- base::file.path(base_path, out_dir, gpkg)
  meta_path <- base::file.path(base_path, out_dir, meta_file)
  
  if (base::file.exists(meta_path)) {
    base::file.remove(meta_path)
  }
  
  meta_file <- base::file(
    description=meta_path, 
    open="at"
    )
  
  base::on.exit(expr=base::close(meta_file))
  
  base::writeLines(glue::glue("# {state} Data Dictionary\n\n"), meta_file)
  
  if (state == "NY") {
    state_list <- c("NY", "NJ", "CT", "RI", "MA", "PA")

    counties_list <- list(
      "NY" = c(
        "Westchester", "Rockland", "Bronx", "Kings",
        "Queens", "New York", "Richmond", "Nassau", "Suffolk"
      ),
      "NJ" = c(
        "Hudson", "Bergen", "Passaic", "Essex",
        "Union", "Middlesex", "Monmouth"
      ),
      "CT" = c("Western Connecticut")
    )

    place_meta <- NY_META
    
    boroughs <- get_nyc_boroughs(
      crs=crs
    ) |>
      sf::st_write(
        dsn=gpkg_path,
        layer=place_meta$boroughs$layer_name,
        delete_layer=TRUE
      ) |>
      write_meta(NY_META$boroughs, meta_file)
    
    clip_geom <- boroughs |>
      dplyr::filter(name == "Bronx") |>
      sf::st_union()
    
    rm(boroughs)
    
    openspace <- get_nyc_openspace(crs=crs)
    
    munis <- get_ny_adjacent_munis(crs=crs)
    
    buildings <- get_nyc_buildings(crs=crs)
    
    transit_agency <- "MTA"
    
    bike_fac <- get_nyc_bikefac(crs=crs)
    
  } else if (state == "MA") {
    state_list <- c("NY", "CT", "RI", "MA", "NH", "VT", "ME")

    counties_list <- list(
      "MA" = c(
        "Middlesex", "Suffolk", "Norfolk", "Essex", "Plymouth", "Bristol"
      )
    )
    place_meta <- MA_META
    
    munis <- get_ma_munis(crs=crs)
    
    clip_geom <- munis |>
      dplyr::filter(
        name %in% c("Boston", "Cambridge", "Somerville", "Brookline")
      ) |>
      sf::st_union()
    
    openspace <- get_ma_openspace(crs=crs)
    
    buildings <- get_ma_buildings(
      MA_MUNIS, 
      crs=crs
      )
    
    transit_agency <- "MBTA"
    
    bike_fac <- get_ma_bikefac(
      crs=crs
      )  |>
      write_meta(MA_META$bike_facilities, meta_file)
    
  } else {
    stop("Only NY and MA are supported.")
  }
  
  buildings  |>
    write_meta(place_meta$buildings, meta_file) |>
    sf::st_write(
      dsn=gpkg_path,
      layer=place_meta$buildings$layer_name,
      delete_layer=TRUE
    )
  
  rm(buildings)
  
  transit <- get_transit(
    agency=transit_agency, 
    crs=crs
  )
  
  transit$routes |>
    write_meta(place_meta$transit_routes, meta_file) |>
    sf::st_write(
      dsn=gpkg_path,
      layer=place_meta$transit_routes$layer_name,
      delete_layer=TRUE
    )
  
  transit$stops |>
    write_meta(place_meta$transit_stops, meta_file) |>
    sf::st_write(
      dsn=gpkg_path,
      layer=place_meta$transit_stops$layer_name,
      delete_layer=TRUE
    )
    
  rm(transit)
  
  bike_fac |>
    st_clip(clip_geom) |>
    write_meta(place_meta$openspace, meta_file) |>
    sf::st_write(
      dsn=gpkg_path,
      layer=place_meta$bike_facilities$layer_name,
      delete_layer=TRUE
    )
  
  rm(bike_fac)
    
  
  openspace  |>
    st_clip(clip_geom) |>
    sf::st_write(
      dsn=gpkg_path,
      layer=place_meta$openspace$layer_name,
      delete_layer=TRUE
    )
  
  rm(openspace)
  
  munis |>
    write_meta(place_meta$munis, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=place_meta$munis$layer_name, 
      delete_layer=TRUE
    )
  
  rm(munis)
  
  get_contours(
    clip_geom,
    crs=crs
  )  |>
    write_meta(OTHER_META$contours, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=OTHER_META$contours$layer_name, 
      delete_layer=TRUE
    )
  
  get_area_water(
    counties_list=counties_list,
    crs=crs,
    year=year
    ) |>
    st_clip(clip_geom) |>
    write_meta(CENSUS_META$area_water, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$area_water$layer_name, 
      delete_layer=TRUE
      )

  get_linear_water(
      counties_list=counties_list,
      crs=crs,
      year=year
      )  |>
    st_clip(clip_geom) |>
    write_meta(CENSUS_META$linear_water, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$linear_water$layer_name, 
      delete_layer=TRUE
      )

  get_roads(
      counties_list=counties_list,
      crs=crs,
      year=year
    ) |>
    st_clip(clip_geom) |>
    write_meta(CENSUS_META$roads, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$roads$layer_name, 
      delete_layer=TRUE
      )

  get_primary_roads(
    states=get_states(
        state_list=state_list,
        crs=crs,
        year=year
      ) |>
      write_meta(CENSUS_META$states, meta_file) |>
      sf::st_write(
        dsn=gpkg_path, 
        layer=CENSUS_META$states$layer_name, 
        delete_layer=TRUE
        ),
    crs=crs,
    year=year
    ) |>
    write_meta(CENSUS_META$primary_roads, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$primary_roads$layer_name, 
      delete_layer=TRUE
      )

  get_primary_secondary_roads(
    counties_list=counties_list,
    counties=get_counties(
      counties_list=counties_list,
      crs=crs,
      year=year
      ) |>
      write_meta(CENSUS_META$counties, meta_file) |>
      sf::st_write(
        dsn=gpkg_path, 
        layer=CENSUS_META$counties$layer_name, 
        delete_layer=TRUE
        ),
    crs=crs,
    year=year
    ) |> 
    write_meta(CENSUS_META$primary_secondary_roads, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$primary_secondary_roads$layer_name, 
      delete_layer=TRUE
      )

  get_block_groups(
    state=state,
    crs=crs,
    year=year
    ) |>
    st_clip(clip_geom) |>
    write_meta(CENSUS_META$block_groups, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$block_groups$layer_name, 
      delete_layer=TRUE
      )

  get_tracts(
    state=state,
    crs=crs,
    year=year
    ) |>
    st_clip(clip_geom) |>
    write_meta(CENSUS_META$tracts, meta_file) |>
    sf::st_write(
      dsn=gpkg_path, 
      layer=CENSUS_META$tracts$layer_name, 
      delete_layer=TRUE
      )
}

get_supp_data <- function(
    base_path, 
    out_dir, 
    year, 
    meta_file,
    ma_gpkg,
    ny_gpkg,
    ma_crs, 
    ny_crs
    ) {
  
  ny_gpkg_path <- base::file.path(base_path, ny_gpkg)
  ma_gpkg_path <- base::file.path(base_path, ma_gpkg)
  meta_path <- base::file.path(base_path, meta_file)
  
  out_path <- file.path(base_path, out_dir)
  dir.create(out_path, showWarnings = FALSE)
  
  
  if (base::file.exists(meta_path)) {
    base::file.remove(meta_path)
  }
  
  meta_file <- base::file(
    description=meta_path, 
    open="at"
  )
  
  base::on.exit(expr=base::close(meta_file))
  
  base::writeLines(glue::glue("# Supplementary Data Dictionary\n\n"), meta_file)

  # Charles River Watershed
  get_watershed(
    point=sf::st_sfc(
      sf::st_point(c(-71.094611, 42.351986)), 
      crs=4269
      ),
    crs=ma_crs
    ) |>
    write_meta(MA_META$watershed, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(
          MA_META$watershed$layer_name, 
          "shp", 
          sep="."
          )
        ),
      delete_layer=TRUE
    )
  
  # Bronx River Watershed
  get_watershed(
      point=sf::st_sfc(
        sf::st_point(c(-73.87759, 40.85072)), 
        crs=4269
      ),
      crs=ny_crs
    )  |>
    write_meta(NY_META$watershed, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(
          NY_META$watershed$layer_name, 
          "shp", 
          sep="."
          )
        ),
      delete_layer=TRUE
    )
  
  get_nyc_cso(
      crs=ny_crs, 
    ) |>
    write_meta(NY_META$cso_drainage, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(
          NY_META$cso_drainage$layer_name, 
          "shp", 
          sep="."
          )
        ),
      delete_layer=TRUE
    )
  
  parcels <- get_nyc_parcels(crs=ny_crs)

  parcels$assess |>
    write_meta(NY_META$assess, meta_file) |>
    readr::write_csv(
      file=file.path(
        out_path,
        stringr::str_c(
          NY_META$assess$layer_name,
          "csv",
          sep="."
          )
      ),
      append=FALSE
    )

  parcels$parcels |>
    write_meta(NY_META$parcels, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(NY_META$parcels$layer_name, "shp", sep=".")
        ),
      delete_layer=TRUE
    )
  
  utils::download.file(
    "https://s-media.nyc.gov/agencies/dcp/assets/files/pdf/data-tools/bytes/pluto_datadictionary.pdf",
    file.path(
      out_path,
      "pluto_metadata.pdf"
    )
  )
  
  parcels <- get_ma_parcels(
    MA_MUNIS,
    crs=ma_crs
    )

  parcels$assess |>
    write_meta(MA_META$assess, meta_file) |>
    readr::write_csv(
      file=file.path(
        out_path,
        stringr::str_c(
          MA_META$assess$layer_name,
          "csv",
          sep="."
        )
      ),
      append=FALSE
    )
  
  parcels$parcels |>
    write_meta(MA_META$parcels, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(MA_META$parcels$layer_name, "shp", sep=".")
        ),
      delete_layer=TRUE
    )

  get_demographics(
    geography="cbg",
    state="MA",
    year=year,
    crs=ma_crs
  ) |>
    st_clip(
      sf::st_read(
          dsn=ma_gpkg_path,
          layer=MA_META$munis$layer_name
        ) |>
        dplyr::filter(
          name %in% c("Boston", "Cambridge", "Somerville", "Brookline")
        ) |>
        sf::st_union()
    ) |>
    write_meta(CENSUS_META$demos_boston, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(CENSUS_META$demos_boston$layer_name, "shp", sep=".")),
      delete_layer=TRUE
    )
  
  get_demographics(
    geography="cbg",
    state="NY",
    year=year,
    crs=ny_crs
  ) |>
    st_clip(
      sf::st_read(
        dsn=ny_gpkg_path,
        layer=NY_META$boroughs$layer_name
      ) |>
        dplyr::filter(name == "Bronx") |>
        sf::st_union()
    ) |>
    write_meta(CENSUS_META$demos_bronx, meta_file) |>
    sf::st_write(
      dsn=file.path(
        out_path, 
        stringr::str_c(CENSUS_META$demos_bronx$layer_name, "shp", sep=".")),
      delete_layer=TRUE
    )
}

runner <- function() {
  dir.create(BASE_PATH, showWarnings = FALSE)
  
  get_base_data(
    state="NY",
    base_path=BASE_PATH,
    out_dir="",
    gpkg=stringr::str_c(NY_FILENAME, "gpkg", sep="."),
    crs=NY_CRS,
    year=CENSUS_YEAR,
    meta_file=stringr::str_c(
      NY_FILENAME, 
      stringr::str_c(
        "dictionary",
        "md",
        sep="."
      ),
      sep="_")
  )
  
  get_base_data(
    state="MA",
    base_path=BASE_PATH,
    out_dir="",
    gpkg=stringr::str_c(MA_FILENAME, "gpkg", sep="."),
    crs=MA_CRS,
    year=CENSUS_YEAR,
    meta_file=stringr::str_c(
      MA_FILENAME, 
      stringr::str_c(
        "dictionary",
        "md",
        sep="."
      ),
      sep="_")
  )
  
  get_naturalearth_data(
    base_path=BASE_PATH, 
    out_dir="",
    gpkg=stringr::str_c(NE_FILENAME, "gpkg", sep="."),
    scale=NE_SCALE,
    crs=NE_CRS,
    graticule_intervals=GRATICULE_INTERVALS,
    meta_file=stringr::str_c(
      NE_FILENAME, 
      stringr::str_c(
        "dictionary",
        "md",
        sep="."
      ),
      sep="_")
  )
  
  
  get_supp_data(
    base_path=BASE_PATH,
    out_dir=SUPP_FILENAME,
    ma_gpkg=stringr::str_c(MA_FILENAME, "gpkg", sep="."),
    ny_gpkg=stringr::str_c(NY_FILENAME, "gpkg", sep="."),
    year=CENSUS_YEAR, 
    meta_file=stringr::str_c(
      SUPP_FILENAME, stringr::str_c(
        "dictionary",
        "md",
        sep="."
      ),
      sep="_"),
    ma_crs=MA_CRS, 
    ny_crs=NY_CRS
  )
}

if(!interactive()){
  runner()
}