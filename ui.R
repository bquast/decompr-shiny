# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
# library(wiod)
# data(wiod95)
data(leather)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("decompr: GVC decomposition"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       # sliderInput("bins",
       #             "Number of bins:",
       #             min = 1,
       #             max = 50,
       #             value = 30),
       selectInput("countries",
                   "Countries object:",
                   choices = ls(.GlobalEnv),
                   selected = countries),
       selectInput("industries",
                   "Industries object:",
                   choices = ls(.GlobalEnv),
                   selected = "industries"),
       selectInput("intermediate",
                   "Intermediate object:",
                   choices = ls(.GlobalEnv),
                   selected = "inter"),
       selectInput("final",
                   "Final object",
                   choices = ls(.GlobalEnv),
                   selected = "final"),
       selectInput("output",
                   "Output object",
                   choices = ls(.GlobalEnv),
                   selected = "output"),
       actionButton("update","Run model")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       # plotOutput("distPlot"),
       tableOutput("text1"),
      
       tableOutput("decomposed")
    )
  )
))
