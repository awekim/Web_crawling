#######################################################################
##  Made by: Keungoui Kim (Ph.D.) 
##  Title: Youtube crawling using R-Selenium
##  goal: Getting title and comments
#######################################################################

library(httr)
library(rvest)
library('RSelenium')

# cd "path"
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445

remd <- remoteDriver(remoteServerAddr="localhost",
                     port=4445L, browserName="chrome")
remd$open()

search.keyword <- "스마트시티"

# Search Youtube
remd$navigate(paste0("http://www.youtube.com/result?search_query=",search.keyword))
remd$navigate(paste0("https://www.youtube.com/results?search_query=%EC%8A%A4%EB%A7%88%ED%8A%B8%EC%8B%9C%ED%8B%B0"))

html <- remd$getPageSource()[[1]]
html <- read_html(html)

youtube_title <- html %>% html_nodes("#video-title") %>% html_text()
length(youtube_title)

# Word filtering
youtube_title <- gsub('\n','',youtube_title)
youtube_title <- trimws(youtube_title)

#####################################
### Load all comments
#####################################

remd$open()

remd$navigate(paste0("https://www.youtube.com/watch?v=B5gmV3Aqo5M"))

# skip log-in
later <- remd$findElement(using="css selector", 'button')
later$clickElement()

# stop video
stopbtn <- remd$findElement(using="css selector", value=".html5-main-video")
stopbtn$clickElement()

# scroll page
remd$executeScript("window.scrollTo(0,10)")

# read html
html <- remd$getPageSource()[[1]]
html <- read_html(html)

youtube_comments <- html %>% html_nodes("#content-text") %>% html_text()

# Word filtering
youtube_comments <- gsub('\n','',youtube_comments)
youtube_comments <- trimws(youtube_comments)

