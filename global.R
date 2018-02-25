library(dplyr)
library(readr)

readFile <- function(inputfile){
  read_csv(inputfile$datapath,
           col_types = cols(
             `Start Date` = col_date(format = c("%m/%d/%y")))) 
}

getListings <- function(dat){
  unique(dat$Listing)
}

processData <- function(dat, selected_listing){
  print(selected_listing)
  dat %>% 
    filter(Type == "Reservation") %>% 
    select(`Start Date`, Nights, Listing) %>% 
    filter(Listing == selected_listing) %>%
    distinct() %>% 
    mutate(`End Date` = `Start Date`+(Nights-1))
}

calculateDateOverlap <- function(beginning, end, dat){
  dates <- sapply(dat$`Start Date`, function(x){
    foo <- filter(dat, `Start Date`==x)
    bar <- seq(as.Date(foo$`Start Date`), as.Date(foo$`End Date`), by = "days")
    bar <- as.Date(bar)
    })

  dates <- do.call("c", dates)
  denom.dates <- seq(as.Date(beginning),as.Date(end), by = "days")
  dates.overlap <- dates[dates %in% denom.dates]
  perc.occ <- signif((length(dates.overlap)/length(denom.dates))*100,3)

  c(length(denom.dates), length(dates.overlap), perc.occ)
}


