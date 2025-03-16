library(shiny)
library(httr)
library(jsonlite)
library(DT)


source("ui.R")      # Load UI
source("server.R")  # Load Server

shinyApp(ui = ui, server = server)
