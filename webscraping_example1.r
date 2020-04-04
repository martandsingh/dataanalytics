# Author: Codemaker
# Date: 04 Apr 2020
# Like us: https://www.facebook.com/codemakerz
# Scope: rvest R library Demo - In this demo we will show you how to perform web scraping.
# Note: This script is just for testing and educational purpose, we do not support any personal or 
# commercial interest with it. It is totally your responsibility how you use it.

library(rvest)

# host url
url <- "https://www.worldometers.info/coronavirus/"
raw_data <- read_html(url)
raw_data
class(raw_data) # xml_nodes

# Get the total count -html_node get the first element matching
total_count <- raw_data %>% html_node(".maincounter-number") %>% html_text()
total_count <- total_count %>% trimws()
total_count <-  gsub(",", "", total_count)
print(total_count)

# Get total deaths - we will use html_nodes - will get all the nodes and then we will pick 2nd element
total_deaths <- raw_data %>% html_nodes(".maincounter-number") 
total_deaths <- total_deaths[2] %>% html_text()
total_deaths <- total_deaths %>% trimws() 
total_deaths <- gsub(",", "", total_deaths)
total_deaths

# Get recovered
total_recovered <- raw_data %>% html_nodes(".maincounter-number") 
total_recovered <- total_recovered[3] %>% html_text()
total_recovered <- total_recovered %>% trimws() 
total_recovered <- gsub(",", "", total_recovered)
total_recovered

# Getting tabular data
# getting headers
today_data_header <- raw_data %>% html_node("#main_table_countries_today") %>% html_node("thead") %>% html_text()
headers <- strsplit(today_data_header, "\n")
headers <- headers[[1]] # header names ready

# getting data
today_data <- raw_data %>% html_node("#main_table_countries_today") %>% html_node("tbody")
for(item in 1:length(today_data)){
  #val <- item %>%  html_node("tr")
  print("1")
}


final_table_data <- raw_data %>% html_nodes("table") %>% .[[2]] %>% html_table %>% .[1:12]
class(final_table_data)

names(final_table_data) # so final we have total one day summary
# We can collect all variables in a datafrane
case_death_summary <- data.frame("Total Cases" = total_count
                                 , "Total Deaths" = total_deaths
                                 , "Total Recovered"  = total_recovered)


# Output
case_death_summary
head(final_table_data)


