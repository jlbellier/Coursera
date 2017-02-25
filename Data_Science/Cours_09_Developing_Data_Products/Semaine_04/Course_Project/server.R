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
library(leaflet)

# Load file managing the dataset 
source("utils.R",encoding = "UTF-8",local=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
   
    # Define a dropdown list based on the regions
    output$Region <- renderUI({
        selectInput("Region","Region",choices = c("All",Regions))
    })
    
    # Define a dropdown list based on the departments
    output$Department <- renderUI({
        selectInput("Department","Department",choices=c("All",Departments))
    })

    # This reactive variable lists dynamically the events that occur in the selected region and/or department
    ListEvents <- reactive({
        selectedReg <- input$Region
        selectedDep <- input$Department

        selectedDep <- ifelse(is.null(selectedDep),"All",selectedDep)
        selectedReg <- ifelse(is.null(selectedReg),"All",selectedReg)
        #ListeEvents <- clean_Jour_Pat_2016_2
        filterDep = TRUE
        filterReg = TRUE
        if (!is.null(selectedDep) & selectedDep !="All") {
            filterDep = (clean_Jour_Pat_2016_2$Departement==selectedDep)
        }

        if (!is.null(selectedReg) & selectedReg !="All") {
            filterReg = (clean_Jour_Pat_2016_2$Region==selectedReg)
        }

        #print("filters")
        #print(filterDep)
        #print(filterReg)
        filter(clean_Jour_Pat_2016_2,filterReg & filterDep)
    })
    
    
    observe({
        myRegion <- input$Region
        if (is.null(myRegion)) myRegion <- "All"
        # Filter the departments linked to the selected region
        if (myRegion == "All"){
            
            listeEvtsRegion <- clean_Jour_Pat_2016_2 
        }
        else{
            listeEvtsRegion <- clean_Jour_Pat_2016_2 %>% filter(Region==myRegion)
        }
         
        listeDep <- listeEvtsRegion$Departement  %>% unique() %>% sort()

        updateSelectInput(session, "Department", choices = c("All",listeDep))

    })

    output$View <- DT::renderDataTable({
        checkData <- is.null(ListEvents())
        #print("checkData")
        #print(checkData)
        data_to_load <-if (checkData) 
        {
            clean_Jour_Pat_2016_2[,DisplayedColumns]
        } 
        else
        {
            {ListEvents()}[,DisplayedColumns]
        }
        #print("data_to_load")
        #print(data_to_load)
        colnames(data_to_load) <- paste0('<span style="color:blue">',c("Location Name","Event name","Town","Department","Region","Event Description","Location Description"),'</span>')
        DT::datatable(data_to_load,escape=FALSE)
        
        },
        options = list(orderClasses = TRUE))

    hr()
    output$map <- renderLeaflet({
        
        # get the position for each monument
        Long <- {ListEvents()}$Longitude
        Lat <-  {ListEvents()}$Latitude
        Descr_Event <- paste({ListEvents()}$Titre_FR,{ListEvents()}$Nom_du_lieu,{ListEvents()}$Ville,sep="; ")
        Web_Site <- {ListEvents()}$Site_web_du_lieu
        
        URL=sapply(Web_Site, function(x) {ifelse(nchar(x) > 0,paste("<a href=","'",x,"'>Web site</a>"),"")})
     
        my_map <- leaflet() %>% addTiles() %>% 
            addMarkers(data= {ListEvents()},lng = Long, lat=Lat,clusterOptions = markerClusterOptions(),popup=paste(Descr_Event,URL,sep=" "))
        my_map
    })

})
