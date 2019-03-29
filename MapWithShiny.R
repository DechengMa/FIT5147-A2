library(shiny)
library(leaflet)

ui <- fluidPage(
  # create map canvas on the page
  leafletOutput("mymap"), 
  # create a button, and bind it to the recalc event
  actionButton("recalc", "New points") 
)

server <- function(input, output, session) {
  # event handle, in this case for click event
  points <- eventReactive(input$recalc, { 
    # calculate normal distribution random points around Melbourne
    cbind(rnorm(40) * 3 + 145.0431, rnorm(40) -37.8773) 
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({ # create leaflet map
    leaflet() %>% 
      addTiles() %>%
      # use the random generated points as markers on the map
      addMarkers(data = points()) 
  })
}

shinyApp(ui, server)