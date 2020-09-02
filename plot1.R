#'@header Coursera Exploratory Data Analysis Course Project 2
#'@date 24/8/2020
#'@title Plot 1
#'@objective Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

# Observe for missing datapoints
sapply(NEI, function(x) sum(is.na(x))) # No missing data recorded

# 3.0 Reshaping Data
library(dplyr)
q1data = NEI %>% group_by(year) %>% summarise(sum_emission = sum(Emissions))

# 4.0 Plot using Base
png("plot1.png", width=480, height=480)
plot(q1data$year,q1data$sum_emission,type = "l",col = "red",main = "Total Emissions PM 2.5 in United States [1999-2008]",ylab = "Total PM 2.5 Emissions",xlab = "Year")
dev.off()
