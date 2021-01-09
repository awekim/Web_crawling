#######################################################################
##  Made by: Keungoui Kim (Ph.D.) 
##  Title: Set-up for R-Selenium
##  goal: Introduce two options for running R-Selenium
#######################################################################

######################################################
#### Option 1
######################################################

# 1) Create r_selenium folder in the desktop
# and download files from the following list
# https://github.com/mozilla/geckodriver/releases/tag/v0.17.0
# https://sites.google.com/a/chromium.org/chromedriver/
# https://www.seleniumhq.org/download/
  
# 2) Open CMD and run following code
# cd "path"
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445

# 3) Install and import library
library(httr)
library(rvest)
library('RSelenium')

remote.d <- remoteDriver(remoteServerAddr="localhost",
  port=4445L, browserName="chrome")
remote.d$open() # Opens chrome browswer


######################################################
#### Option 2
######################################################

# This much easier and efficient.
# R does all the tired tasks for you.

library(rvest)
library('RSelenium')
library(wdman) # chrome
library(binman) # list_versions

port <- 50000L
driver <- chrome(port=port) # R does it all automatically. downloading, updating, etc.
remote.d <- remoteDriver(port = port, browserName = 'chrome')
remote.d$open()

# If it does not work because of chrome driver difference, 
# do the following task.

# get list of chrome versions
list_versions(appname='chromedriver')
# reset driver by selecting the same chrome version
# Make sure your chrome driver version is lower than your chrome!
driver <- chrome(port=port, version ='87.0.4280.20') 
port <- 50001L

remote.d <- remoteDriver(port = port, browserName = 'chrome')
remote.d$open()

### Note!
# Port issue
# R-selenium only receives "integer" 
# L converts it to "integer"