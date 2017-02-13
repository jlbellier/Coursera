#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyr)
library(dplyr)
library(ggplot2)
library(leaflet)


# Read input CSV file
Paris_visits_df <- read.csv("Paris_monuments_visitors.csv",sep=";",header=TRUE)

#Get the list of years
visit_years <- select(Paris_visits_df,Year) %>% unique()
print(visit_years)
#Get the characteristics of monuments
Monuments <- select(Paris_visits_df, -c(Nb_visitors,Year)) %>% unique()
#print(dim(Monuments))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  output$Year <- renderUI({
        selectInput("Year", "Visit year :", choices=as.character(visit_years[,1]),selected="2010")})
    
  output$barPlot <- renderPlot({

  # First we check the existence of input$Year
  #if (is.null(input$Year) || is.na(input$Year)){
  #        return()
  #    }
  #    else
  #{
    Visits_Year    <- filter(Paris_visits_df,Year==input$Year) 
    
    
    # draw a barplot giving the number of visitors by monument for the selected year
    ggplot(data=Visits_Year, aes(x=Monument, y=Nb_visitors)) +
        ggtitle(paste("Public attendance for year",input$Year,sep=" ")) + 
        geom_bar(stat="identity", fill="steelblue")+
        ylab("Number of visitors") + xlab("") + 
        geom_text(aes(label=Nb_visitors), vjust=1.6, color="white", size=3.5)+
        theme(axis.text.x = element_text(angle = 45, hjust = 1,size=12),
              plot.title = element_text(color="red", size=14, face="bold",hjust=0.5))
   # }
  })
  
  output$map <- renderLeaflet({
      
      # get the position for each monument
      Long <- Monuments$Longitude
      Lat <-  Monuments$Latitude
      MonumentName <- Monuments$Monument
      URL <-  paste("<a href=","'",Monuments$URL,"'>",MonumentName,"</a>")
      my_map <- leaflet() %>% addTiles() %>% addMarkers(lng = Long, lat=Lat,popup=URL)
      my_map
      
  })
})
