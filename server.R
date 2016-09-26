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
      
      var_x <- inter
      var_y <- final
      var_k <- countries
      var_i <- industries
      var_o <- out
      
      if (input$dataselect == "upload") {
        var_x <- .GlobalEnv[[input$intermediate]]
        var_y <- .GlobalEnv[[input$final]]
        var_k <- .GlobalEnv[[input$countries]]
        var_i <- .GlobalEnv[[input$industries]]
        var_o <- .GlobalEnv[[input$output]]
      } 
      
      .decomposed <<- decomp(
        x = var_x,
        y = var_y,
        k = var_k,
        i = var_i,
        o = var_o,
        method = input$method,
        post = input$post     )
        
      output$decomposed <- renderTable({.decomposed})
    }
  })
  
  output$downloadData <- downloadHandler(
    filename = function()
      paste(input$dataselect, '-', input$method, '.csv', sep=''),
    content = function(tempfile)
      write.csv(.decomposed, file = filetemp)
  )

})
