# Bastiaan Quast
# bquast@gmail.com
# http://qua.st/
# http://qua.st/decompr

library(shiny)
library(decompr)
data(leather)
# library(wiod)
# data(wiod95)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("decompr: GVC decomposition"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("countries",
                   "Countries object:",
                   choices = ls(.GlobalEnv),
                   selected = "countries"),
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
                   selected = "out"),
       radioButtons("method", 
                    "Decomposition method:",
                    choices = c("Leontief" = "leontief", "Wang-Wei-Zhu" = "wwz")),
       actionButton("update","Run model")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tableOutput("decomposed")
    )
  )
))
