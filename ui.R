#library(shinyapps)
library(ggplot2)
library(shiny)

dataset <- read.csv("GL_Demographics_filtered.csv")
dataset <- dataset[dataset$ProductMarketCode=='ETUS',]
dataset<-dataset[which(dataset$BusinessUnitCode=='USEAST' | dataset$BusinessUnitCode=='USWEST'),]
shinyUI(pageWithSidebar(
  
  headerPanel("GL  Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
    selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
    selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
  ),
  
  mainPanel(
    plotOutput('plot')
  )
))