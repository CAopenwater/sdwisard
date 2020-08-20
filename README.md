# sdwisard 🧙💧🧪

Query tool for SDWIS (Safe Drinking Water Information System)

This package was developed as an entry to the CA Water Data Challenge 2020.  It demonstrates the utility of easy to use API wrappers to empower analysts to get more done with data with less effort. Currently the SDWIS database is inconvenient  to query and there is no public facing API. This wrapper grabs data hosted in an AWS s3 bucket so we can pretend there is already the infrastructure to support this type of development. 

## Installation

```r
remotes::install_github(repo = "CAopenwater/sdwisard")
```

## Basic Usage

```r
sdwisard::get_data(psid, start_date, end_date, analyte) 
```

For more details see our [Getting Started](https://CAopenwater.github.io/sdwisard/articles/getting-started.html) article.
