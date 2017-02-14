# tractR
Simple R Wrapper for the [Census Batch Geocoder API](https://geocoding.geo.census.gov/geocoder/)

![tractR](assets/tractR.png?raw=true "tractR")

### Installation
Using the R package [`devtools`](https://www.rstudio.com/products/rpackages/devtools/), you can easily install `bcstatsR`.
```{r}
devtools::install_github('vikjam/bcstatsR')
```

### Use
```{r}
library(tractR)
CAMBRIDGE_URL <- 'https://data.cambridgema.gov/api/views/crnm-mw9n/rows.csv?accessType=DOWNLOAD&bom=true'
assessing     <- fread(CAMBRIDGE_URL, nrows = 10)
assessing$id  <- 1:nrow(assessing)
assessing$Zip <- str_pad(assessing$Zip, 5, pad = '0')

assessing.geo <- getTracts(data       = assessing,
                           unique_id  = 'id',
                           address    = 'Mailing Address',
                           city       = 'City',
                           state      = 'State',
                           postalcode = 'Zip')

print(assessing.geo)
```
| id|submit.addr                                             |match    |quality   |result.addr                                    |lat.lon             |  tiger.id|side | state| county|  tract| block|
|--:|:-------------------------------------------------------|:--------|:---------|:----------------------------------------------|:-------------------|---------:|:----|-----:|------:|------:|-----:|
|  3|P.O. BOX#19, CAMBRIDGE, MA, 02141                       |No_Match |          |                                               |                    |        NA|     |    NA|     NA|     NA|    NA|
|  2|14 HILL STREET, WOBURN, MA, 01801                       |Match    |Exact     |14 HILL ST, WOBURN, MA, 01801                  |-71.11787,42.479633 |  87105447|L    |    25|     17| 333400|  1026|
|  1|225 MONSIGNOR OBRIEN HWY, CAMBRIDGE, MA, 02141          |Match    |Exact     |225 MONSIGNOR OBRIEN HWY, CAMBRIDGE, MA, 02141 |-71.080376,42.37281 |  87108564|R    |    25|     17| 352101|  1006|
| 10|777 E. EISENHOWER PKWY SUITE #235, ANN ARBOR, MA, 48108 |No_Match |          |                                               |                    |        NA|     |    NA|     NA|     NA|    NA|
|  7|79 CHANDLER ST., #6, BOSTON, MA, 02116                  |Match    |Exact     |79 CHANDLER ST, BOSTON, MA, 02116              |-71.07247,42.346565 |  85698106|R    |    25|     25|  70300|  3003|
|  6|P.O. BOX 444, WEST HYANNISPORT, MA, 02672               |No_Match |          |                                               |                    |        NA|     |    NA|     NA|     NA|    NA|
|  5|261 LEDYARD ST., NEW LONDON, CT, 06320                  |Match    |Exact     |261 LEDYARD ST, NEW LONDON, CT, 06320          |-72.10897,41.36469  |  56850523|R    |     9|     11| 690300|  1013|
|  4|262 MONSIGNOR O'BRIEN HWY, CAMBRIDGE, MA, 02141         |Match    |Non_Exact |262 MONSIGNOR OBRIEN HWY, CAMBRIDGE, MA, 02141 |-71.08212,42.37369  |  87090708|L    |    25|     17| 351500|  1033|
|  9|4 CANAL PK, UNIT #109, CAMBRIDGE, MA, 02141             |Match    |Exact     |4 CANAL PARK, CAMBRIDGE, MA, 02141             |-71.07678,42.36993  | 636268605|R    |    25|     17| 352102|  1001|
|  8|4 CANAL PARK #108, CAMBRIDGE, MA, 02141                 |Match    |Exact     |4 CANAL PARK, CAMBRIDGE, MA, 02141             |-71.07678,42.36993  | 636268605|R    |    25|     17| 352102|  1001|

### Credits
The tractR logo is a mash-up of logos from the Noun Project: Tractor (Oliviu Stoian), Wagon (Symbolon), and US Map (DeeAnn Gray).
