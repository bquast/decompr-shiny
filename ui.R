# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
# data(leather)
# library(wiod)
# data(wiod95)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("decompr: GVC decomposition"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons("dataselect", 
                    "Select dataset:",
                    choices = c('Example dataset "leather"' = "leather",
                                "WIOD 1995" = "wiod95",
                                "WIOD 2000" = "wiod00",
                                "WIOD 2005" = "wiod05",
                                "WIOD 2008" = "wiod08",
                                "WIOD 2009" = "wiod09",
                                "WIOD 2010" = "wiod10",
                                "WIOD 2011" = "wiod11",
                                "upload data" = "upload")),
       conditionalPanel( condition = 'input.dataselect == "upload"',
         fileInput("file", "Upload an RData file:"),
         uiOutput("countries"),
         uiOutput("industries"),
         uiOutput("intermediate"),
         uiOutput("final"),
         uiOutput("output")
       ),
       
       radioButtons("method", 
                    "Decomposition method:",
                    choices = c("Leontief" = "leontief", "Wang-Wei-Zhu" = "wwz")),
       
       conditionalPanel( condition = 'input.method == "leontief"',
         radioButtons("post", 
                      "Post-multiplication (Leontief only):",
                      choices = c("exports", "output", "final_demand", "none"))
       ),
       
       actionButton("update","Run model")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       downloadButton('downloadData', 'Download'),
       tableOutput("decomposed")
    )
  )
))
