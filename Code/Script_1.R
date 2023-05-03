
###Loading libraries
install.packages('tidyverse')
install.packages('here')
install.packages('readxl')

library(tidyverse)
library(here)
library(readr)
library(ggplot2)
library(readxl) 



###---------------------------------------------------------------Loading data--------------------------------------------------------

## loading the workbook from the data file, skipping the first 7 rows and selcting the sheet "all years"


raw_data <- read_excel(here('Data','Weekly_Fuel_Prices.xlsx'),skip=7,sheet='All years')



###--------------------------------------------------------------Data Wrangling----------------------------------------------------------
head(raw_data)

###next steps are to: 
###1) remove useless columns keeping just price per litre for diesel and petrol respectively - done
###2) give better names to the variables ULSP = petrol, ULSD = diesel - done
###3) round diesel and petrol up to 2 decimal places - to do 

clean_data <- raw_data %>% 
  rename("Petrol"="ULSP:  Pump price (p/litre)",
         "Diesel"="ULSD: Pump price (p/litre)") %>% 
  select(Date,Petrol,Diesel)

###gonna pivot the table to make plotting petrol and diesel together easier 

df <- pivot_longer(clean_data, 
             -Date,
             names_to="Cat",
             values_to="Value")


head(clean_data)

###--------------------------------------------------------Creating the Visualization----------------------------------------------
### What do I want from the graph 
### 1) different colour lines for diesel and petrol
### 2) legends descibing colour code, X and Y axis, and a title 
### 3) axis is probably going to need adjusting 


##ggplot(df=clean_data, 
##       mapping=aes(x=Date,y=Petrol))
##p+geom_smooth()

####creates a basic graph 
ggplot(df, aes(x=Date, 
               y=Value,
               colour=Cat))+
  geom_line()+
  labs(title="Fuel Prices Over the Past 20 Years",
       x="Date", y="Price Per Litre (p)",
       color="Fuel Type")



#ggplot(data=clean_data, aes(x=Date))+
#  geom_line(aes(y=Diesel), color="darkred")+
#  geom_line(aes(y=Petrol), color="steelblue")

