ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h5("Upload your Transactions file from Air. This can be obtained on the Airbnb Transaction History page by clicking 'export csv.'"),
      fileInput("data", "Upload STR CSV",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      uiOutput("listingselection"),
      dateInput("begindate", "Beginning Date", value = NULL, min = NULL, max = NULL,
                format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                language = "en", width = NULL),
      dateInput("enddate", "End Date", value = NULL, min = NULL, max = NULL,
                format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                language = "en", width = NULL)
    ),
    
    mainPanel(
      textOutput("length"),
      textOutput("overlap"),
      textOutput("percentoccupancy")
    )
  )
)