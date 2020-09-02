#'@header Coursera Exploratory Data Analysis Course Project 2
#'@date 24/8/2020
#'@title Plot 6
#'@objective Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California

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

# 3.0 Reshaping Data
# Since the objective is relatively vague, i attempted a few checks before confirming the dataset to be used for the plot
library(dplyr)

# Verdict: We will use the same methodology as Q5
scc_vehicle = SCC[apply(SCC,1,function(x) any(grepl("vehicle", x, ignore.case = TRUE))),]

scc_vehicle_lookup = sapply(scc_vehicle,unique)

nei_vehicle = NEI %>% filter(fips  %in% c("24510","06037") & SCC %in% scc_vehicle$SCC)
nei_vehicle_lookup = sapply(nei_vehicle,unique)
q6data = nei_vehicle %>% group_by(year,fips,type) %>% summarise(sum_emission = sum(Emissions)) %>% ungroup() %>% 
  mutate(fips = case_when(
    fips == "24510" ~ "Baltimore",
    fips == "06037" ~ "Los Angeles"
  ))

# 4.0 Plot using Ggplot2
library(ggplot2)

plot6 = ggplot(q6data,aes(year,sum_emission,color = type))+
  geom_line()+
  geom_point()+
  ggtitle("Motor Vehicle PM 2.5 Emissions for Baltimore and Los Angeles by Type [1999-2008]")+
  xlab("Year")+
  ylab("Total PM 2.5 Emissions")


png("plot6.png", width=480, height=480)

plot6 + facet_grid(. ~ fips)

dev.off()
