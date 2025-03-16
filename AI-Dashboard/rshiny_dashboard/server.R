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