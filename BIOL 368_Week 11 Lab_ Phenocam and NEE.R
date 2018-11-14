################# SEASONAL VARIATION IN ECOSYSTEM GREENNESS AND CARBON EXCHANGE ###########
#### NOVEMBER 13, 2018 LAB - PLANT ECOPHYSIOLOGY ###

#############################################################

#Load ggplot and phenocamr packages
library(ggplot2)
library(phenocamr)

#We will start with one of the older datasets from phenocam: Harvard Forest. 

#First we download the data, this creates a huge file.
download_phenocam(site = "harvard$",
                  veg_type = "DB",
                  roi_id = "1000",
                  frequency = "3")

#Make a dataframe "df" from the file: 
df <- read_phenocam(file.path(tempdir(),"harvard_DB_1000_3day.csv"))
data_Harvard<-df$data
#View the data from the df file: 
View(data_Harvard)

#Let's use GGPLOT, not base R plot, to visualize our data: 

#First we plot the WHOLE dataset, which starts in 2008, you can see there are multiple points per day:
ggplot(data_Harvard, aes(doy, gcc_mean))+
  geom_point()+
  geom_smooth(method="loess", span=0.1)+
  theme_classic()

#Next let's separate years by color: 
ggplot(data_Harvard, aes(doy, gcc_mean, colour=year))+
  geom_point()+
  geom_smooth(method="loess", span=0.1)+
  theme_classic()+
  scale_color_viridis_c() #this can be changed to a different color scheme

#Now let's plot each year individually: 
ggplot(data_Harvard, aes(doy, gcc_mean, colour=doy))+
  geom_point()+
  geom_smooth(method="loess", span=0.1, col="black")+
  theme_classic()+
  scale_color_viridis_c()+
  facet_wrap(~year)

#Now time to download data from a new site and recreate these graphs in ggplot!

##############################################

### Part III: Eddy covariance data ###

#############################################

#Download the AMF_Ha1 dataset from the email to the class. Save to your desktop and 
#Import into Rstudio Server: 
#Files>Upload>select the data from the desktop>Import Data

## This is eddy covariance data from Harvard Forest. I truncated the dataset to be from 2008-2018, 
## to align with the phenocam data. Data is an average of 1 hr measurements for every day. 
## When data doesn't log, a "-9999" value in inserted. To plot and assess the data, we will remove 
## "-9999" values. 

#Making a column for Year
AMF_US_Ha1_BASE_HR_10_1$Year<-substr(AMF_US_Ha1_BASE_HR_10_1$Date_time, 1,4)
AMF_US_Ha1_BASE_HR_10_1$Date2<-substr(AMF_US_Ha1_BASE_HR_10_1$Date_time, 1,8)

#### Removing -9999 from NEE_PI, RECO_PI, FPAR, APAR, TA
AMF_US_Ha1_BASE_HR_10_1$TA[AMF_US_Ha1_BASE_HR_10_1$TA %in% -9999] <- NA
AMF_US_Ha1_BASE_HR_10_1$NEE_PI[AMF_US_Ha1_BASE_HR_10_1$NEE_PI %in% -9999] <- NA
AMF_US_Ha1_BASE_HR_10_1$RECO_PI[AMF_US_Ha1_BASE_HR_10_1$RECO_PI %in% -9999] <- NA
AMF_US_Ha1_BASE_HR_10_1$APAR[AMF_US_Ha1_BASE_HR_10_1$APAR %in% -9999] <- NA
AMF_US_Ha1_BASE_HR_10_1$FAPAR[AMF_US_Ha1_BASE_HR_10_1$FAPAR %in% -9999] <- NA

### Create a daily average of values using the package dplyr ##
library(dplyr)
AMF_Ha1_dailymean<-AMF_US_Ha1_BASE_HR_10_1%>%
  group_by(Date2)%>%
  summarise_all(funs(mean), na.rm=TRUE)

##Add a column for Year, for some reason it got wiped out: 
AMF_Ha1_dailymean$Year<-substr(AMF_Ha1_dailymean$Date2, 1,4)
AMF_Ha1_dailymean$Date1<-c(NA,NA, NA,NA,data_Harvard$date[1:2919])
AMF_Ha1_dailymean$DOY<-c(NA,NA, NA,NA,data_Harvard$doy[1:2919])


## Next let's plot the NEE data to see annual trends from 2008-2018
ggplot(AMF_Ha1_dailymean, aes(DOY, NEE_PI, colour=Year))+
  geom_point()+
  geom_smooth(method="loess", span=0.1, se=FALSE)+
  theme_classic()

#Separate by year with facet_wrap
ggplot(AMF_Ha1_dailymean, aes(DOY, NEE_PI, colour=Year))+
  geom_point()+
  geom_smooth(method="loess", span=0.1, se=FALSE)+
  theme_classic()+
  facet_wrap(~Year)

