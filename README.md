# sdwisard 🧙💧🧪

Query tool for SDWIS (Safe Drinking Water Information System)

## Query functions
```r
sdwisard::query_psid(psid, start_date, end_date, analytes)
sdwisard::query_county(county, start_date, end_date, analytes)
sdwisard::find_water_system(zipcode) returns psid and water system name
sdwisard::query_analyte(psid) returns df with anayle, date coverage
```

## Package objects

```r
# data.frame of psid, water_system_name, county, zipcode
sdwisard::psids 
```

## Getting started
```r
sdwisard::query_psid(psid, start_date, end_date, analytes) %>%
  filter(analyte == “PFAS”) %>%
  ggplot(ase(time, value)) %>%
  geom_line() 
```
