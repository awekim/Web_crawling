#######################################################################
##  Made by: Keungoui Kim (Ph.D.) 
##  Title: Naver crawling using R-Selenium
##  goal: Getting title and comments
#######################################################################

library(httr)
library(rvest)
library('RSelenium')

# cd "path"
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445

remote.d <- remoteDriver(remoteServerAddr="localhost",
                         port=4445L, browserName="chrome")
remote.d$open() # Opens chrome browswer

remote.d$navigate(url ='http://www.naver.com')

###########################################
###### Finding HTML elmement and Run 
###########################################

# You have two options
# 1) Find by using devTool (F12) -> Xpath
# 2) Find by using SelectorGadget -> css selector

# Option 1) type then click
query <- remote.d$findElement(using ='xpath', value='//*[@id="query"]')
query$sendKeysToElement(sendKeys = list('손흥민'))
query.btn <- remote.d$findElement(using='xpath', value='//*[@id="search_btn"]')
query.btn$clickElement()

# Option 2) type and click
# remote.d$open() # Opens chrome browswer
# remote.d$navigate(url ='http://www.naver.com')
# 
# query <- remote.d$findElement(using ='xpath', value='//*[@id="query"]')
# query$sendKeysToElement(sendKeys = list('손흥민','\uE007'))

### Click News section
news <- remote.d$findElement(using='xpath', value='//*[@id="lnb"]/div[1]/div/ul/li[4]/a')
news$clickElement()

### Change page
remote.d$goBack()
remote.d$goForward()

### Refresh
remote.d$refresh()

### close
remote.d$close()

###########################################
###### Loading HTML
###########################################

remote.d$open() # Opens chrome browswer

naver.hot.url <- "https://datalab.naver.com/keyword/realtimeList.naver?where=main"

remote.d$navigate(url =naver.hot.url)

# get all HTML 
html <- remote.d$getPageSource()[[1]] # list

items <- html %>% read_html() %>% html_nodes(css='ul.ranking_list > li')

items %>% html_node(css='span.item_title') %>% html_text()
