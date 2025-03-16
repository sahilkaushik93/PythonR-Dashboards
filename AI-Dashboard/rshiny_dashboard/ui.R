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