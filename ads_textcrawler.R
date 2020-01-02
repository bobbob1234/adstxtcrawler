library(rvest)
library(reshape2)
library(readxl)
library(plyr)
library(tidyr)
library(dplyr)
library(data.table)
library(xml2)
library(XML)
library(stringr)
library(RSelenium)
library(seleniumPipes)
library(rvest)
library(wdman)
library(httr)
library(RSelenium)
getOption("HTTPUserAgent")
options(HTTPUserAgent= "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0")
#setwd("~/Ammnet/CrawlData")
remDr <- remoteDriver(
  remoteServerAddr = "192.168.1.7",
  port = 4445L
)
rd <- rsDriver(port = 4449L,browser = "firefox")
remDr <- rd$client
##### AD EXCHANGE CRAWLER ####
count <- 1
length <- 1:39
# for(count in 1:39){
# 
# url <-  paste("https://www.adstxt.com/exchanges?page=",count)
# url <- gsub(" ","",url)
# remDr$navigate(url)
# remDr$getTitle(url)
# html_obj_results <- remDr$getPageSource(header=T)[[1]] %>% read_html()
# a<- html_nodes(html_obj_results,xpath = '/html/body/div/main/div/div[2]/table')
# a2 <- html_table(a)
# pastingurl <- paste("C:/Users/cebojo01/Documents/Ammnet/CrawlData/page",count,".csv")
# pastingurl <- gsub(" ","",pastingurl)
# write.csv(a2,file = pastingurl)
# count = count + 1
# }
# temp = list.files(pattern="page")
# myfiles = lapply(temp, read.csv)
# myfiles <- do.call(rbind.data.frame,myfiles)
# write.csv(myfiles,"C:/Users/cebojo01/Documents/Ammnet/CrawlData/exchange_data.csv")



#### ADS_TEXT_VALIDATION####
adist <-  read.csv("C:/Users/cebojo01/Documents/Ammnet/CrawlData/distinct_ads_txt_urls.csv")
urlsize = 1:nrow(adist)
count <- 1
compiled <- data.frame()
url2 <- adist$adstxt_url


for(count in urlsize){
tryCatch({
adadelem = remDr$findElement(using = c("xpath"),"//*[@id='ad_txt_domain']")
elem$sendKeysToElement(list(url2[count],key="enter"))
Sys.sleep(3)
#remDr$deleteAllCookies()
html_obj_results <- remDr$getPageSource(header=T)[[1]] %>% read_html()
a <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[1]/div/div/h3')
a2 <- html_text(a) %>% as.numeric()
b <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[2]/div/div/h3')
b2 <- html_text(b) %>% as.numeric()
#c <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[3]/div/div/h3')
#c2 <- html_text(c) %>% as.numeric()
c <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[4]/div/div/h3')
d <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[5]/div/div/h3')
d2 <- html_text(d) %>% as.numeric()
e <- html_nodes(html_obj_results,xpath = '/html/body/div[1]/div[2]/div[6]/div/div/h3')
e2 <- html_text(e) %>% as.numeric()
compiled[count,1] <- url2[count]
compiled[count,2] <- a2
compiled[count,3] <- b2
compiled[count,4] <- d2
compiled[count,5] <- e2
count = count + 1
},error = function(e){cat("ERROR:",conditionMessage(e),"\n")})
}

colnames(compiled) <- c("Errors","Warnings","Notices")
