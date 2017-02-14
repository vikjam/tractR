#' Wrapper for the U.S. Census Batch Geocoder
#'
#' This function allows you to submit batch geocoders
#' @param data The data to be geocoded
#' @param unique_id The unique identifier required for each row in the data
#' @param address The street address to be geocoded
#' @param city The city for the address
#' @param state The state for the address
#' @param postalcode The postal code for the address
#' @keywords geocding, census, api
#' @importFrom data.table fread data.table
#' @importFrom pbapply pblapply
#' @importFrom httr POST upload_file content
#' @export

getTracts <- function(data, unique_id, address, city, state, postalcode) {
  addr_vars   <- c(unique_id, address, city, state, postalcode)
  retrieve_dt <- data[ , addr_vars, with = FALSE]

  result_dt   <- do.call('rbind',
                         pblapply(split(retrieve_dt, (1:nrow(retrieve_dt) %/% 10000)),
                                  .fetchGeo))

  return(result_dt)
}

.fetchGeo <- function(dt_submit) {

  CENSUS_URL = 'https://geocoding.geo.census.gov/geocoder/geographies/addressbatch'

  csv_submit <- tempfile(pattern = "", fileext = '.csv')
  write.table(x         = dt_submit,
              file      = csv_submit,
              sep       = ',',
              row.names = FALSE,
              col.names = FALSE)

  results <- POST(CENSUS_URL,
                  encode = 'multipart', 
                  body   = list(addressFile = upload_file(csv_submit), 
                                benchmark   = 'Public_AR_Current',
                                vintage     = 'Current_Current'))

  addr <- content(results, 'text', encoding = 'UTF-8')
  rm(results)

  result.names <- c('id', 'submit.addr', 'match', 'quality', 'result.addr',
                    'lat.lon', 'tiger.id', 'side', 'state', 'county',
                    'tract', 'block')

  addr <- read.table(text      = addr,
                     header    = FALSE,
                     fill      = TRUE,
                     col.names = result.names,
                     sep       = ',')

  unlink(csv_submit)
  return(addr)
}
