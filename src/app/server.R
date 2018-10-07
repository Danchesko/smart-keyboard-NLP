library(shiny);
library(stringr);
library(tm)

bigram <- readRDS("tdm/bigram.RData")
trigram <- readRDS("tdm/trigram.RData")
quadrogram <- readRDS("tdm/quadgram.RData")

names(bigram)[names(bigram) == 'word1'] <- 'w1'
names(bigram)[names(bigram) == 'word2'] <- 'w2'

names(trigram)[names(trigram) == 'word1'] <- 'w1'
names(trigram)[names(trigram) == 'word2'] <- 'w2'
names(trigram)[names(trigram) == 'word3'] <- 'w3'

names(quadrogram)[names(quadrogram) == 'word1'] <- 'w1'
names(quadrogram)[names(quadrogram) == 'word2'] <- 'w2'
names(quadrogram)[names(quadrogram) == 'word3'] <- 'w3'
names(quadrogram)[names(quadrogram) == 'word4'] <- 'w4'

message <- ""

predictWord <- function(the_word) {
  
  word_add <- stripWhitespace(removeNumbers(removePunctuation(tolower(the_word),preserve_intra_word_dashes = TRUE)))
  the_word <- strsplit(word_add, " ")[[1]]
  n <- length(the_word)

  if (n == 1) {the_word <- as.character(tail(the_word,1)); functionBigram(the_word)}
  
  else if (n == 2) {the_word <- as.character(tail(the_word,2)); functionTrigram(the_word)}
  
  else if (n >= 3) {the_word <- as.character(tail(the_word,3)); functionQuadrogram(the_word)}
}

functionBigram <- function(the_word) {
  
  if (identical(character(0),as.character(head(bigram[bigram$w1 == the_word[1], 2], 1)))) {
    message<<-"If no word found the most used three words will be returned" 
    as.character(c('the', 'and', 'for'))
  }
  else {
    message <<- "Predicting next word using Bigram Frequency Matrix  "
    as.character(head(bigram[bigram$w1 == the_word[1],2], 3))
  }
}


functionTrigram <- function(the_word) {
  if (identical(character(0),as.character(head(trigram[trigram$w1 == the_word[1]
                                                  & trigram$w2 == the_word[2], 3], 1)))) {
    as.character(predictWord(the_word[2]))
}
  else {
    message<<- "Predicting next word using Trigram Fruequency Matrix "
    as.character(head(trigram[trigram$w1 == the_word[1]
                         & trigram$w2 == the_word[2], 3], 3))
  }
}


functionQuadrogram <- function(the_word) {
  if (identical(character(0),as.character(head(quadrogram[quadrogram$w1 == the_word[1]
                                                  & quadrogram$w2 == the_word[2]
                                                  & quadrogram$w3 == the_word[3], 4], 1)))) {
    as.character(predictWord(paste(the_word[2],the_word[3],sep=" ")))
  }
  else {
    message <<- "Predicting next word using Quadrogram Frequency Matrix"
    as.character(head(quadrogram[quadrogram$w1 == the_word[1] 
                         & quadrogram$w2 == the_word[2]
                         & quadrogram$w3 == the_word[3], 4], 3))
  }       
}

shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- predictWord(input$inputText)
    output$sentence2 <- renderText({message})
    result
  });
  output$sentence1 <- renderText({
    input$inputText});
}
)