#The Script is used with SAP Analytics Cloud R Visualization builder
#Tokenize text from Non Conformance Comments columns and then Untest Tokens to arrange them with frequency
# generate Bar plot with top Tokens found

# load package
library(wordcloud)
library("dplyr")
library(stringr)
library(tidytext) 
# get words
d=nonconformance_new_D100[!(!is.na(nonconformance_new_D100$comment) & nonconformance_new_D100$comment=="" & nonconformance_new_D100$comment=="unassigned"), ]
d$text <- as.character(d$comment)
c=unnest_tokens(d, input = text, output = word) %>% count(word, name = "frequency")
words <- c[-c(45),]$word   # I have manually removed from not necessary tokens
# get frequency
stopwords=c("not","of","in","a","aaaa","is","on","was","unassigned")
c<-c %>%
  filter(!(c$word %in% stopwords))
frequency <- c$frequency
c=c[-c(45),][order(frequency,decreasing=TRUE),]
# generate word cloud
barplot(c$frequency, main="", horiz=FALSE,col="red",
  names.arg=c$word,las=2)
c
