library(shiny)
library(datasets)
library(ggplot2) # load ggplot
library(leaflet)
library(scales)
library(stringr)

coralData <- read.csv('./assignment-02-data-formated.csv')



shinyServer(function(input, output) {
  output$mpgPlot <- reactivePlot(function() {
    # check for the input variable
    options(digits=5)
    coralData <- data.frame(year = coralData$year, 
                            # as.double(coralData$value)
                            #  as.double (stri_sub(coralData$value, 1, -4))
                            value = as.numeric(as.character(str_sub(coralData$value, 1, -2)))/100,
                            location = coralData$location,
                            latitude = coralData$latitude,
                            coralType = coralData$coralType)
    
    coralData <- subset(coralData, coralType == input$variable)
    print(coralData$value / 100)
    
    p <- ggplot(coralData, aes(year, value, color = sample)) + 
      geom_point(aes(color = location)) +
      scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
      facet_grid(coralType~reorder(location, latitude)) +
      xlab(input$variable) + 
      theme(strip.text = element_text(colour = 'white'), axis.line = element_line(), axis.ticks.y = element_line(), ) +
      geom_smooth(aes(group = 1),
                  method = input$smootherMethod,
                  color = input$color,
                  formula = y~ poly(x, 2),
                  se = FALSE,
                  size= 0.4)
    
    p <- p + scale_color_manual(values = c("site01" = "red", "site02" = "blue",  "site03" = "green",  "site04" = "darkgreen", "site05" = "black", "site06" = "yellow", "site07" = "orange", "site08" = "purple"))
    print(p)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- reactiveText(function() {
    paste("Value for coral kind: ", input$variable)
  })
  
  check <- function(x) {
    iconColor =  ifelse(x=="site01", "red", 
                        ifelse(x=="site02","blue",
                               ifelse(x=="site03","green",
                                      ifelse(x=="site04","darkgreen",
                                             ifelse(x=="site05","black",
                                                    ifelse(x=="site06","yellow",
                                                           ifelse(x=="site07","orange",
                                                                  ifelse(x=="site08","purple","white"))))))))
    result <- makeAwesomeIcon(icon = 'none', markerColor = iconColor,
                              library='ion')
    
    return(result)
  }
  
  output$coralMap <- renderLeaflet({ 
    leaflet(coralData)  %>% addTiles()  %>% addAwesomeMarkers(
      ~longitude, 
      ~latitude, 
      popup = ~as.character(location),
      icon = ~check(as.character(location))
    )
  })
  
})