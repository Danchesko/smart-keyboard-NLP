library(shiny)
library(markdown)

shinyUI(
  fluidPage(
    column(5,offset = 4, 
    titlePanel("Data Science Capstone - Smart Keyboard")),
    sidebarLayout(
      sidebarPanel(
        helpText("Enter a word or a sentence, to see predictions for next word"),
        hr(),
        textInput("inputText", "Enter the text or a sentence here",value = ""),
        hr(),
        helpText("After the input, up to 3 words can be predicted"),
        hr()
      ),
      mainPanel(
        h2("See what words were predicted by algorithm here"),
        verbatimTextOutput("prediction"),
        strong("Text entered:"),
        strong(code(textOutput('sentence1'))),
        br(),
        strong("N-grams:"),
        strong(code(textOutput('sentence2'))),
        hr()
      )
    )
  )
)