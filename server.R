library(shiny)
library(datasets)
library(ggplot2) # load ggplot

coralData <- read.csv('./assignment-02-data-formated.csv')

shinyServer(function(input, output) {
  output$mpgPlot <- reactivePlot(function() {
    # check for the input variable
   
    coralData <- data.frame(year = coralData$year, 
                            value = coralData$value,
                            location = coralData$location,
                            latitude = coralData$latitude,
                            coralType = coralData$coralType)
    
    print("AAAAA")
    print(input$variable)
    print(input$color)
    
    coralData <- subset(coralData, coralType == input$variable)
    
    p <- ggplot(coralData, aes(year, value)) + 
      geom_point() +
      scale_y_discrete(breaks = seq(0, 1, by = 0.2))  + 
      facet_grid(coralType~reorder(location, latitude)) +
      xlab(input$variable) +
      geom_smooth(aes(group = 1),
                  method = input$smootherMethod,
                  color = input$color,
                  formula = y~ poly(x, 2),
                  se = FALSE)
    print(p)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- reactiveText(function() {
    paste("Value for coral kind: ", input$variable)
  })
  
})