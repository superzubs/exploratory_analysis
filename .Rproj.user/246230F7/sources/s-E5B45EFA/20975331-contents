#'@header Coursera Exploratory Data Analysis Course Project 2
#'@date 24/8/2020
#'@title Download Data
#'@objective To download data if needed

# 1.1 Declaring filenames and path for download to commence
zip_name = "exdata_data_NEI_data.zip"
zipped_url ="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

file_names = unzip(zip_name, exdir = "data",list = T)$Name 
file_names = paste0(getwd(),"data/",file_names)


# 1.2 File Downloading Process
if(!file.exists(file_names) & !file.exists(zip_name)){
  download.file(url = zipped_url,destfile = zip_name,mode = "wb") 
  unzip(zip_name, exdir = "data")
}else{
  unzip(zip_name, exdir = "data")
}


