#'@header Coursera Exploratory Data Analysis Course Project 2
#'@date 24/8/2020
#'@title Plot 4
#'@objective Using the ggplot2 plotting system, understanding changes to coal combustion-related sources from 1999-2008?

# 1.0 Declaring filenames and path for download to commence
zip_name = "exdata_data_NEI_data.zip"
zipped_url ="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

file_names = unzip(zip_name, exdir = "data",list = T)$Name 
file_names = paste0(getwd(),"data/",file_names)


# 1.1 File Downloading Process
if(!file.exists(file_names) & !file.exists(zip_name)){
  download.file(url = zipped_url,destfile = zip_name,mode = "wb") 
  unzip(zip_name, exdir = "data")
}else{
  unzip(zip_name, exdir = "data")
}

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 2.0 Do background check on Data
str(NEI)
summary(NEI)
str(SCC)
summary(SCC)

## Finding shows that some columns are not in the suitable classes for str and summary to be used. 

unique_of_NEI = sapply(NEI,unique) # The list's length shows uniqueness of each column
unique_of_SCC = sapply(SCC,unique)

# Observe for missing datapoints
sapply(NEI, function(x) sum(is.na(x))) # No missing data recorded.
sapply(SCC, function(x) sum(is.na(x))) # Missing data recorded in two columns.
# Check coal related sources from SCC Data
coal_lookup = SCC[grepl("coal",SCC$Short.Name,ignore.case = T),]

# 3.0 Reshaping Data
library(dplyr)
q4data = NEI %>% filter(SCC %in% coal_lookup$SCC) %>% group_by(year,type) %>% summarise(sum_emission = sum(Emissions)) 

# 4.0 Plot using Ggplot2
library(ggplot2)
png("plot4.png", width=480, height=480)

ggplot(q4data,aes(year,sum_emission,col = type))+
  geom_line()+
  geom_point()+
  ggtitle("Total PM 2.5 Emissions of Coal Related Sources in US by Type [1999-2008]")+
  xlab("Year")+
  ylab("Total PM 2.5 Emissions")+
  scale_fill_discrete(name = "Sources")

dev.off()
