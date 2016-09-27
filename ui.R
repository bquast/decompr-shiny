# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
# data(leather)
library(wiod)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Google Analytics
  tags$head(includeScript("google-analytics.js")),
  
  # Application title
  titlePanel("decompr: GVC decomposition"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons("dataselect", 
                    "Select dataset:",
                    choices = c('Example dataset "leather"' = "leather",
                                "WIOD" = "wiod",
                                "TiVa" = "tiva",
                                "upload data" = "upload")),
       conditionalPanel( condition = 'input.dataselect == "wiod"',
                         selectInput("wiodselect", "Choose year for WIOD:",
                                     choices = c("WIOD 1995" = "95",
                                                 "WIOD 2000" = "00",
                                                 "WIOD 2005" = "05",
                                                 "WIOD 2008" = "08",
                                                 "WIOD 2009" = "09",
                                                 "WIOD 2010" = "10",
                                                 "WIOD 2011" = "11") )
       ),
       
       conditionalPanel( condition = 'input.dataselect == "tiva"',
                         selectInput("tivaselect", "Choose year for TiVa:",
                                     choices = c("TiVa 1995" = "tiva95",
                                                 "TiVa 2000" = "tiva00",
                                                 "TiVa 2005" = "tiva05",
                                                 "TiVa 2008" = "tiva08",
                                                 "TiVa 2009" = "tiva09",
                                                 "TiVa 2010" = "tiva10",
                                                 "TiVa 2011" = "tiva11") )
       ),
       
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
       
       actionButton("update","Run model"),
       
       checkboxInput("showoutput", "Show output", value=TRUE),
       
       a("© 2016 Bastiaan Quast", href="http://qua.st/", target="_blank"),
       h5(' '),
       a("Built using decompr, ", href="http://qua.st/decompr/", target="_blank"),
       a("please cite: Quast & Kummritz 2015", href="https://ideas.repec.org/p/gii/cteiwp/ctei-2015-01.html", target="_blank")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       downloadButton('downloadData', 'Download Output Data'),
       
       conditionalPanel( condition = 'input.showoutput == true',
         tableOutput("decomposed")
       ) 
    )
  )
))
