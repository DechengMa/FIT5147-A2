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
    
    coralData <- subset(coralData, coralType == input$variable)
    
    p <- ggplot(coralData, aes(year, value, color = sample)) + 
      geom_point(aes(color = location)) +
      scale_y_discrete(breaks = seq(0, 1, by = 0.2))  + 
      facet_grid(coralType~reorder(location, latitude)) +
      xlab(input$variable) + 
      theme(strip.text = element_text(colour = 'white')) +
      geom_smooth(aes(group = 1),
                  method = input$smootherMethod,
                  color = input$color,
                  formula = y~ poly(x, 2),
                  se = FALSE)
    
    p <- p + scale_color_manual(values = c("site01" = "red", "site02" = "blue",  "site03" = "green",  "site04" = "darkgreen", "site05" = "black", "site06" = "yellow", "site07" = "orange", "site08" = "purple"))
    print(p)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- reactiveText(function() {
    paste("Value for coral kind: ", input$variable)
  })
  
  check <- function(x) {
    print("~~~")
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
  
  output$coralMap <- renderLeaflet({ # create leaflet map
    leaflet(data)  %>% addTiles()  %>%
    addAwesomeMarkers(
      ~longitude, 
      ~latitude, 
      popup = ~as.character(location),
      icon = ~check(as.character(location))
    )
  })
  
})