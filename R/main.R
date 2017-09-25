# Week 4 Quiz

# Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#
# and load the data into R. The code book, describing the variable names is here:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?

# OK, start by getting the file (just read the codebook in a browser)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/community.csv")
communityData <- read.csv("./data/community.csv")

# Split the names of the data frame on "wgtp"
splitNames = strsplit(names(communityData),"wgtp") # The extra slash is a qualifier because the period is a reserved character

# get the 123rd element
splitNames[[123]]
# the result is:
# ""   "15"

# clear the entire workspace before the next question
rm(list=ls())

# Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
#
# Original data sources:
#
#  http://data.worldbank.org/data-catalog/GDP-ranking-table

# # OK, start by getting the file (just read the codebook in a browser)
library(data.table)

if(!file.exists("./data")){dir.create("./data")}
setwd(getwd() + "./data" )
GDPfileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
GDPdestFile <- "./data/gdp.csv"
download.file(GDPfileUrl,destfile=GDPdestFile,mode="wb")

# Load into table
GDPtable <- fread(GDPdestFile, skip = 4, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "LongName", "GDP"))

# Use gsub to replace the commas with nothing then cast as numeric
GDPtable$GDP <- as.numeric(gsub(",","",GDPtable$GDP))

mean(GDPtable$GDP)
# [1] 377652.4

# Don't clear the workspace.  Just proceed.

# Question 3
# In the data set from Question 2 what is a regular expression that would allow you to count the number
# of countries whose name begins with "United"?
# Assume that the variable with the country names in it is named countryNames.
# How many countries begin with United?

countryNames <- GDPtable$LongName

# How to find how many countries start with United?  Use carat.

grep("^United",countryNames)

# How many are there?
[1]  1  6 32

# There are 3


# clear the entire workspace before the next question
rm(list=ls())

# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#
# Load the educational data from this data set:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available,
# how many end in June?
#
# Original data sources:
#
#  http://data.worldbank.org/data-catalog/GDP-ranking-table
#
# http://data.worldbank.org/data-catalog/ed-stats

# Load the data.table library.
library(data.table)

# Get GDP and EDU data
if(!file.exists("./data")){dir.create("./data")}
setwd(getwd() + "./data" )
GDPfileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
EDUfileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
GDPdestFile <- "./data/gdp.csv"
EDUdestFile <- "./data/edu.csv"
download.file(GDPfileUrl,destfile=GDPdestFile,mode="wb")
download.file(EDUfileUrl,destfile=EDUdestFile,mode="wb")

# Load into tables
GDPtable <- fread(GDPdestFile, skip = 4, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "LongName", "GDP"))

EDUtable <- fread(EDUdestFile)

# Merge the tables by country code
MERGEtable <- merge(GDPtable, EDUtable, by = 'CountryCode')

# Which records have an end of fiscal year?
EOFtable <- MERGEtable[grep("Fiscal year end",MERGEtable$`Special Notes`)]

# Of those, how many end in June?
grep("Fiscal year end: June",EOFtable$`Special Notes`)

# Count it manually if there are too many
nrow(EOFtable[grep("Fiscal year end: Jun",EOFtable$`Special Notes`)])

# [1] 13

# clear the entire workspace before the next question
rm(list=ls())

# Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for
# publicly traded companies on the NASDAQ and NYSE. Use the following code to download data
# on Amazon's stock price and get the times the data was sampled.
#
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

# Run the code that was provided
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# I needed examples.  http://www.quantmod.com/examples/intro/

length(grep("^2012-", sampleTimes))
# there are 250 observations

#Yeah, but now many of those on Mondays?

sampleTimes <- sampleTimes[grep("^2012-", sampleTimes)]
length(grep("Monday", weekdays(sampleTimes)))
# There were 47





nrow(grep("^2012-", sampleTimes))

xxx <- grep("^2012-", sampleTimes)
















































