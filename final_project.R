library(tidyverse)

detailed_results <- fina_join()
detailed_results %>% group_by(series) %>% summarise(n = n())
library(shiny)

ui <- fluidPage(
  sidebarLayout(selectizeInput("Competition",
                               label = "Choose the Competition",
                               choices = detailed_results$series),
  mainPanel(navlistPanel(
             tabPanel("Champions Series", "content"),
             tabPanel("Championships (25m)", "contents"),
             tabPanel("Championships (50m)", "contents"),
             tabPanel("Junior Championships", "contents"),
             tabPanel("Marathon Series", "contents"),
             tabPanel("Olympic Games", "contents"),
             tabPanel("World Cup", "contents"),
             tabPanel("Youth Olympic Games", "contents"))))
)
server <- function(input, output, session) {
  competition_name <- reactive({
    detailed_results %>% filter(series == detailed_results$series)
  })
}

shinyApp(ui, server)
