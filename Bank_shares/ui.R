#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
    titlePanel("Stock performance for three main Spanish banks"),
    sidebarLayout(
        sidebarPanel(
            checkboxInput("san","Santander", value = FALSE),
            checkboxInput("bbva","BBVA", value = FALSE),
            checkboxInput("cabk","Caixa", value = FALSE),
            selectInput("period","Period of Time",c("Last 5 days","Last 15 days","Last month")),
            submitButton("Submit")
        ),
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
