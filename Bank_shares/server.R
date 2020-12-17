#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyquant)
library(ggplot2)

shinyServer(function(input, output) {
    stock <- reactive({
        data <- tq_get(c("BBVA.MC", "SAN.MC", "CABK.MC"), 
                       get = "stock.prices", 
                       from = today()-30, 
                       to = today())
        data$check <- FALSE
        data[data$symbol == "BBVA.MC",]$check <- input$bbva
        data[data$symbol == "SAN.MC",]$check <- input$san
        data[data$symbol == "CABK.MC",]$check <- input$cabk
        data <- data[data$check==TRUE,]
        if (input$period == "Last 5 days"){
            data[data$date%in%(today():(today()-5)),]
        } else if (input$period == "Last 15 days"){
            data[data$date%in%(today():(today()-15)),]
        } else {data}
        })
    output$distPlot <- renderPlot({
        ggplot(data = stock(), aes(date,close)) +
            geom_line(aes(col=symbol))+
            xlab(input$period)+
            ylab("Share value at Closure")+
            labs(col="Stock")+
            theme_minimal()
            
    })

})
