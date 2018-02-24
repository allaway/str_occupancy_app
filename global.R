library(dplyr)
library(readr)
library(DescTools)

dat <- read_csv("airbnb_2018.csv",
                col_types = cols(
                  `Start Date` = col_date(format = c("%m/%d/%y")))) %>% 
  filter(Type == "Reservation") %>% 
  select(`Start Date`, Nights, Listing) %>% 
  distinct() %>% 
  mutate(`End Date` = `Start Date`+(Nights-1)) %>% 
  filter(Listing == "Cozy private room near airport with queen bed")  

  
dates <- sapply(dat$`Start Date`, function(x){
  foo <- filter(dat, `Start Date`==x)
  bar <- seq(as.Date(foo$`Start Date`), as.Date(foo$`End Date`), by = "days")
  bar <- as.Date(bar)
})

dates <- do.call("c", dates)

denom.dates <- seq(as.Date("2018-01-20"),as.Date("2018-02-18"), by = "days")
dates.2 <- dates[dates %in% denom.dates]

perc.occ <- (length(dates.2)/length(denom.dates))*100

