---
title       : Presentation
subtitle    : Attendance on parisian monuments between 2010 and 2015
author      : Jean-Luc BELLIER
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Context

Paris monuments are the one that are the most visited in the world. Visitors are coming from everywhere in the world to discover the history of this marvellous sites in this town. 


The goal of this project is to focus on the number of visitors of some Paris monuments between 2010 and 2015. 

The presentation has been made with a shiny presentation :

 * ***leaflet***, to show the geographical position on the monuments
 * ***slidify***, to build the current presentation 

--- 

## The Data

The data have been compiled from the annual reports edited by the Paris tourist office between 2010 and 2015 (http://presse.parisinfo.com/etudes-et-chiffres/chiffres-cles). 

selecting a year in the dropdown list displays a barplot with the number of visitors by monument, and the geolocalization of each monument

For display commodities, a tab panel has been created :

 * "Attendance" : gives the number of visitors by year
 * "Geolocalization" : plots the coordinates of each monument. A popup gives the name of the monument, giving a link to a presentation for each monument

---

## Results

The dashboard on the visits can be loaded here :
https://jlbellier.shinyapps.io/Paris_visits/. 

Feel free to change the visit year and to click on the markers to discover views and information on these monuments.

The material of this dahboard can be found in the folder 

https://github.com/jlbellier/Coursera/tree/master/Data_Science/Cours_09_Developing_Data_Products/Semaine_02/Project_Slides

