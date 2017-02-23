# The goal of this file is to read and prepare the data. The data come from a french open database. 
# The data describe all the monuments and locations that the people could see and visit in France on the European Heritage Days in 2016.


# load libraries
library(dplyr)
library(tidyr)

# Read data
Journees_Patr_2016 <- read.csv("Journees_europeennes_du_patrimoine_20160914.csv", encoding="UTF-8", sep=";",header=TRUE,stringsAsFactors = FALSE)

#Get the number of observations and the number of columns of the file
nb_obs <- dim(Journees_Patr_2016)[1]
nb_col <- dim(Journees_Patr_2016)[2]

# remove empty columns
check_NA <- apply(Journees_Patr_2016,2,function(x) sum(is.na(x)))
cols_to_remove <- which(check_NA == nb_obs)
clean_Jour_Pat_2016 <- select(Journees_Patr_2016,-cols_to_remove)

# Here we will removed the accents from the column names, to make processing easier. 
col_names <- names(clean_Jour_Pat_2016)
print(col_names)
new_col_names <- gsub("è","e",gsub("é","e",gsub(".","_",gsub("...","_",col_names,fixed=TRUE),fixed=TRUE),fixed=TRUE),fixed=TRUE)
Encoding(new_col_names) <- "UTF-8"

colnames(clean_Jour_Pat_2016) <- new_col_names

# We need to draw a map with the localization of the events, so we remove observations 
# with no latitude or longitude
clean_Jour_Pat_2016_2 <- clean_Jour_Pat_2016 %>% subset(!is.na(Latitude) & !is.na(Longitude) & !is.na(Ville) & !is.na(Code_postal))


# Then we get the list of regions and departments
Regions <- clean_Jour_Pat_2016_2$Region %>% unique() %>% sort()
Departments <- clean_Jour_Pat_2016_2$Departement %>% unique() %>% sort()

# At last, we display only the main columns
DisplayedColumns <- c("Nom_du_lieu","Titre_FR","Ville","Departement","Region","Description_FR", "Description_du_lieu_FR")

