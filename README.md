# sdwisard 🧙💧🧪

Query tool for SDWIS (Safe Drinking Water Information System)

First, determine the PSIDs of interest.

## Query metadata
```r 
sdwisard::get_water_system(zipcode, county) # returns psid and water system name for given zipcode
sdwisard::get_analyte_summary(psid)         # returns summarised df of analytes, storet, and date range
sdwisard::get_storet(analyte)               # returns summarised df of analytes, and date range
```

Use PSIDs obtained to query for analytes.
## Query data
```r
sdwisard::get_data(psid, start_date, end_date, analytes) 
```

## Package objects

```r
# data.frame of colnames = c(psid, water_system_name, county, zipcode)
sdwisard::water_systems

# data.frame of colnames = c(storet, analytes)
sdwisard::analytes 

# internal of colnames = c(psid, storet, analyte, start_date, end_date, n))
sdwisard::psid_analyte
```

## Getting started

Query by psid, start_date, end_date, and analyte
```r
sdwisard::get_data(psid, start_date, end_date, analyte)
```
