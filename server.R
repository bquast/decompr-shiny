# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
# library(wiod)
# data(wiod95)
data(leather)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # output$distPlot <- renderPlot({
  #   
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2] 
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
  #   
  # })
  
  observe({
    if(input$update){
      
      output$text1 <- renderTable({ 
        input$countries
      })
      
      output$decomposed <- renderTable({
        decomp(x = input$intermediate,
               y = input$final,
               k = input$countries,
               i = input$industries,
               o = input$output)
      })
    }
  })

  
})
