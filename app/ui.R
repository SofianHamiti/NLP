shinyUI(fluidPage(
  h3("NLP - 3 gram Word prediction"),
  tags$head(tags$style("#text1, #text2{color: blue;
                       font-size: 20px;
                       }"
  )),
  br(),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      h5("Sentence to complete:"),
      textInput("text", label = ""),
      hr(),
      p("This app uses the Stupid Backoff Model to predict the next word."),
      br()
    ),
    
    
    
    mainPanel(
      h5("Predicted word:"),
      hr(),
      h4(textOutput("text1")),
      hr()
    )
  )
  ))