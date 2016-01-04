library(NLP)
library(tm)

load('ngram_global.RData')


predict <- function(input) {
  if(nchar(input) > 0)
  {
    ## process input
    
    # clean data input
    input <- gsub("[^A-Za-z ]","",input)
    input <- tolower(input)   
    
    # we consider the last words
    input <- strsplit(input, " ")
    input <- unlist(input)
    input <- rev(input)
    
    # recompose last 2 words for tri-gram
    input2 <- paste(input[2],input[1],sep = ' ')
    
    # recompose last 1 word for bi-gram
    input1   <- input[1]  
    
    ## predict
    fetch2      <-grepl(paste0("^",input1,"$"),gram2$input)
    fetch3      <-grepl(paste0("^",input2,"$"),gram3$input)
    
    #stupid backoff implementation
    if(sum(fetch3) > 0 )
    {
      # Both trigram & bigram
      predict2    <-gram2[fetch2,]
      predict3    <-gram3[fetch3,] 
      
      #alpha is set to 0.4
      if((predict2$s*0.4) > predict3$s)
      {
        return(predict2$output)
      }
      else
      {
        return(predict3$output)
      }    
    }
    else
    {
      if(sum(fetch2) > 0)
      {
        # no trigram, return bigram
        predict2    <-gram2[fetch2,]
        return(predict2$output)
      } 
      else
      {
        # no trigram nor bigram, return unigram
        return(gram1[1]$unigram)
      }
    }
  }
}


shinyServer(function(input, output) {
  output$text1 <- renderText({predict(input$text)})
})