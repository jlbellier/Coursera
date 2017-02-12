#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

require(shiny)
library(tidyr)
library(dplyr)
require(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Public attendance of some parisian monuments in the last 5 years"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            uiOutput("Year") 
        ),
        
        # Show a plot of the generated distribution
       mainPanel(
            plotOutput("barPlot"),
            leafletOutput("map")
        )
    )
))