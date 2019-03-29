# ui.R
library(shiny)

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
                  c("Black" = "black", 
                    "Blue" = "blue",
                    "Red" = "red",
                    "Green" = "green")
      ),
      selectInput("smootherMethod", "Select a method of smoother:", 
                  c("auto" = "auto", 
                    "lm" = "lm",
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
))