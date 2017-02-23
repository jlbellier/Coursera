#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("European Heritage Days - momuments to visit in 2016"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        uiOutput("Region"),
        uiOutput("Department"),
        span("Table of events and their location are displayed dynamically on the right side of the map. You just need to select a region and/or a department. Note that :"),
        span(tags$ol(tags$li("By default 'All' is selected in both dropdown lists.")
                    ,tags$li("Any change on the region will reset the list of departments.")
                    ,tags$li("Any change on one of the dropdown lists will automatically update the table and the map."))),
        br(),
        span("The table columns can be sorted independently. The sorted column will be designed with a little blue (ascending or descending) arrow."),
        br(),
        span("You can zoom in or out on the map to see the details on the events. A click on any single tick mark will display a popup with the global elements. If a  web site is defined for the event, the appropriate link will be displayed. ")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(tabsetPanel(
        tabPanel("Event list",DT::dataTableOutput("View")),
        tabPanel("Event map",leafletOutput("map"))
    )
        
    )
  )
))
