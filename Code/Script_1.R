
###Loading libraries
install.packages('tidyverse')
install.packages('here')
install.packages('readxl')
#install.packages('lubridate')
#install.packages('viridis')
install.packages('wesanderson')

library(tidyverse)
library(here)
library(readr)
library(ggplot2)
library(readxl) 
library(wesanderson)




###---------------------------------------------------------------Loading data--------------------------------------------------------

## loading the workbook from the data file, skipping the first 7 rows and selcting the sheet "all years"


raw_data <- read_excel(here('Data','Weekly_Fuel_Prices.xlsx'),skip=7,sheet='All years')


save(raw_data,file="Data/Raw_Data.Rdata")



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

save(df,file="Data/Clean_Data.Rdata")
save(df,file="Data/Clean_Data.csv")
###Not needed/didnt work

##df %>% 
##  mutate(Date=as.Date(Date))


#lubridate(date=df$Date)


#as_date(df$Date)
#class(df$Date)

#for(i in 1:500){
#  as_date(df$Date[i])
#}


###--------------------------------------------------------Creating the Visualization----------------------------------------------
### 1) different colour lines for diesel and petrol
### 2) legends descibing colour code, X and Y axis, and a title 
### 3) adjusted x and y axis for orientation and distance between points 
###  4) moved legend under graph
###chnaging line width = geom_line(linewidth=0.75)


plot1 <- ggplot(df, aes(x=Date,y=Value,colour=Cat))+
  geom_line(linewidth=0.75)+ 
  labs(title="Fuel Prices Over the Past 20 Years",x="Date",y="Pence Per Litre",color=NULL)+
  scale_color_manual(limits=c("Petrol","Diesel"),values=wes_palette("Royal1",n=2))+
  scale_x_datetime(date_breaks="1 year",date_labels="%Y")+
  scale_y_continuous(breaks=c(80,100,120,140,160,180,200))+
  theme(axis.text.x=element_text(angle=50,hjust=1),legend.position = "bottom", plot.title=element_text(size=20,hjust=0.5),legend.text=element_text(size=10),legend.key.size=unit(1,"cm"))

plot1

ggsave("Fuel Prices 2003-2023.pdf", plot1, path=here("Plots"))
ggsave("Fuel Prices 2003-2023.png", plot1, path=here("Plots"))
 

`------------------------------------Aesthetics------------------------------------------------------
###WRECKAGE
###  Trying to figure out colours 
  
#ggplot(df,aes(x=Date,y=Value,colour=Cat))+
 # geom_line(linewidth=0.75)+ 
  #labs(title="Fuel Prices Over the Past 20 Years",x="Date",y="Price Per Litre (p)",color="Fuel")+
  #scale_color_manual(limits=c("Petrol","Diesel"),values=wes_palette("GrandBudapest1",n=2))+
  #scale_color_discrete(limits=c("Petrol","Diesel"))+
 # scale_x_datetime(date_breaks="1 year",date_labels="%Y")+
#  scale_y_continuous(breaks=c(80,100,120,140,160,180,200))+
  #theme(axis.text.x=element_text(angle=50,hjust=1),legend.position = "bottom")


#ggplot(df,aes(Date,Value))+
#  geom_line(aes(color=Cat))+
#  scale_color_viridis(disrete=TRUE,option="D",limits=c("petrol","diesel"))
        
#plot.title=element_text(hjust=0.5)) - adjusts title to centre 


      





#df data frame, x axis is dates, y is price per litre, colour coded diesel and petrol
#line graph and adding titles/legends
#rearrange petrol and diesel 



#ggplot(data=clean_data, aes(x=Date))+
#  geom_line(aes(y=Diesel), color="darkred")+
#  geom_line(aes(y=Petrol), color="steelblue")

