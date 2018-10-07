library(tm)

tokenize <- function (x){
  corpus <- Corpus(VectorSource(x))
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, removeWords,stopwords("english"))
  corpus <- tm_map(corpus, removePunctuation) 
  corpus <- tm_map(corpus, removeNumbers) 
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, PlainTextDocument)
}

