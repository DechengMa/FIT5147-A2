# ui.R
library(shiny)
library(leaflet)

# Define UI for miles per gallon application
shinyUI(fluidPage( 
  # Application title
  headerPanel("Coral Bleaching Data"),
  
  # Sidebar with controls to select the variable to plot against
  # mpg and to specify whether outliers should be included
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Select a type of coral:", 
                  c("Blue corals" = "blue corals", 
                    "Sea fans" = "sea fans",
                    "Sea pens" = "sea pens",
                    "Soft corals" = "soft corals",
                    "Hard corals" = "hard corals")
      ),
      selectInput("color", "Select a color of smoother:", 
                  c("Green" = "green",
                    "Black" = "black", 
                    "Blue" = "blue",
                    "Red" = "red")
      ),
      selectInput("smootherMethod", "Select a method of smoother:", 
                  c("lm" = "lm",
                    "auto" = "auto", 
                    "glm" = "glm",
                    "gam" = "gam",
                    "loess"="loess")
      )
    ),
    
    # Show the caption and plot of the requested variable against mpg
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("mpgPlot")
    )
  )
  ,
  headerPanel("Map for Coral Bleaching Data"),
  leafletOutput("coralMap")
))