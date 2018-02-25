server <- function(input, output) {
  
  readdata <- reactive({
    validate({
      need(nrow(input$data>0), message = F)
    })
    readFile(input$data)
  })
  
  output$listingselection <- renderUI({
    dat <- readdata()
    list <- getListings(dat)
    list <- list[!is.na(list)]
    selectInput("listingselection","Select a listing", choices = list, multiple = FALSE)
  })


  occupancyinfo <- reactive({
    dat <- readdata()
    dat <- processData(dat, input$listingselection)
    calculateDateOverlap(input$begindate, input$enddate, dat)
  })

  output$length <- renderText({
    validate({
      need(nrow(input$data>0), message = "Please upload a transactions CSV.")
      need(input$begindate<=input$enddate, message = "Please check the order of your query dates.")
    })
    foo <- occupancyinfo()[[1]]
    paste0("Length of query: ", foo)
  })
  
  output$overlap <- renderText({
    validate({
      need(nrow(input$data>0), message = F)
      need(input$begindate<=input$enddate, message = F)
      
    })
    foo <- occupancyinfo()[[2]]
    paste0("Number of booked days: ", foo)
  })
  
  output$percentoccupancy <- renderText({
    validate({
      need(nrow(input$data>0), message = F)
      need(input$begindate<=input$enddate, message = F)
      
    })
    foo <- occupancyinfo()[[3]]
    paste0("Percent occupancy for query period: ", foo)
  })
  
}