test_that('getTracts returns data.table object', {
    library(stringr)
    CAMBRIDGE_URL <- 'https://data.cambridgema.gov/api/views/crnm-mw9n/rows.csv?accessType=DOWNLOAD&bom=true'
    assessing     <- fread(CAMBRIDGE_URL, nrows = 10)
    assessing$id  <- 1:nrow(assessing)
    assessing$Zip <- str_pad(assessing$Zip, 5, pad = '0')
    assessing     <- data.table(assessing)

    assessing.geo <- getTracts(data       = assessing,
                               unique_id  = 'id',
                               address    = 'Mailing Address',
                               city       = 'City',
                               state      = 'State',
                               postalcode = 'Zip')

    expect_is(assessing.geo, 'data.table') 
})

