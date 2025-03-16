library(shiny)
library(httr)
library(jsonlite)
library(DT)

# source("ui.R")      # Load UI
# source("server.R")  # Load Server

ui <- fluidPage(
    titlePanel("AI-Powered Data Science Dashboard"),
    sidebarLayout(
        sidebarPanel(
            fileInput("datafile", "Upload CSV File"),
            actionButton("train", "Train Model"),
            actionButton("predict", "Get Predictions")
        ),
        mainPanel(
            DTOutput("results"),
            verbatimTextOutput("status")
        )
    )
)

server <- function(input, output) {
    observeEvent(input$train, {
        req(input$datafile)
        file_path <- input$datafile$datapath

        res <- POST("http://127.0.0.1:5000/train",
                    body = list(file = upload_file(file_path)),
                    encode = "multipart")

        output$status <- renderPrint({ content(res)$message })
    })

    observeEvent(input$predict, {
        req(input$datafile)
        file_path <- input$datafile$datapath

        res <- POST("http://127.0.0.1:5000/predict",
                    body = list(file = upload_file(file_path)),
                    encode = "multipart")

        predictions <- content(res)$predictions
        output$results <- renderDT({ data.frame(Predictions = predictions) })
    })
}

shinyApp(ui, server)
# setwd("E:\\Job & Interview Kit\\Revision Material\\DS & Algos - Python & JavaScript\\PythonR-Dashboards\\rshiny_dashboard")
dir.exists("E:/Job & Interview Kit/Revision Material/DS & Algos - Python & JavaScript/PythonR-Dashboards/rshiny_dashboard")
runApp("rshiny_dashboard")
