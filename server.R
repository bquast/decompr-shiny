# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
data(leather)
# library(wiod)
# data(wiod95)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  observe({
    if(input$update){
      
      output$decomposed <- renderTable({
        decomp(x = .GlobalEnv[[input$intermediate]],
               y = .GlobalEnv[[input$final]],
               k = .GlobalEnv[[input$countries]],
               i = .GlobalEnv[[input$industries]],
               o = .GlobalEnv[[input$output]],
               method = input$method,
               post = input$post)
      })
    }
  })

  
})
