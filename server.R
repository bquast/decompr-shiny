# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
# data(leather)
library(wiod)
# data(wiod95)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # check for data upload
  observe({
    inFile <- input$file
    if(!is.null(inFile)){
      load(file = inFile$datapath, envir = .GlobalEnv)
    } else {
      data(leather)
    }
    
    output$countries <- renderUI({
      selectInput("countries", "Countries list:", choices = ls(.GlobalEnv),
                  selected = grep("^[cC][oO][nN]", ls(.GlobalEnv), perl = TRUE, value = TRUE) )
    })
    output$industries <- renderUI({
      selectInput("industries", "Industries / Sectors list:", choices = ls(.GlobalEnv),
                  selected = grep("^[iIsS][nNeC][dDcC]", ls(.GlobalEnv), perl = TRUE, value = TRUE) )
    })
    output$intermediate <- renderUI({
      selectInput("intermediate", "Intermediate Demand matrix:", choices = ls(.GlobalEnv),
                  selected = grep("^[iI][nN][tT]", ls(.GlobalEnv), perl = TRUE, value = TRUE) )
    })
    output$final <- renderUI({
      selectInput("final", "Final Demand matrix:", choices = ls(.GlobalEnv),
                  selected = grep("^[fF][iI][nN]", ls(.GlobalEnv), perl = TRUE, value = TRUE) )
    })
    output$output <- renderUI({
      selectInput("output", "Output vector:", choices = ls(.GlobalEnv),
                  selected = grep("^[oO][uU][tT]", ls(.GlobalEnv), perl = TRUE, value = TRUE) )
    })
  })
  
  observe({
    if(input$update){
      
      .decomposed <<- decomp(x = .GlobalEnv[[input$intermediate]],
               y = .GlobalEnv[[input$final]],
               k = .GlobalEnv[[input$countries]],
               i = .GlobalEnv[[input$industries]],
               o = .GlobalEnv[[input$output]],
               method = input$method,
               post = input$post)
        
      output$decomposed <- renderTable({.decomposed})
    }
  })
  
  output$downloadData <- downloadHandler(
    filename = function()
      paste(input$dataselect, '-', input$method, '.csv', sep=''),
    content = function(file2)
      write.csv(.decomposed, file = file2)
  )

})
