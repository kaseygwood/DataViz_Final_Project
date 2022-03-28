library(tidyverse)

detailed_results <- fina_join()
detailed_results %>% group_by(series) %>% summarise(n = n())
library(shiny)

ui <- fluidPage(
  sidebarLayout(selectizeInput("Competition",
                               label = "Choose the Competition",
                               choices = c("Champions Series", "Championships (25m)", "Championships(50m)", "Junior Championships", "Marathon Series", "Olympic Games", "World Cup", "Youth Olympic Games")),
                radioButtons("Style",
                             label = "Choose the Stroke",
                             choices = c("Medley")),
  navlistPanel(
             tabPanel("Champions Series", "content"),
             tabPanel("Championships (25m)", "contents"),
             tabPanel("Championships (50m)", "contents"),
             tabPanel("Junior Championships", "contents"),
             tabPanel("Marathon Series", "contents"),
             tabPanel("Olympic Games", "contents"),
             tabPanel("World Cup", "contents"),
             tabPanel("Youth Olympic Games", "contents"))))
server <- function(input, output, session) {
  competition_name <- reactive({
    detailed_results %>% filter(series == input$Competition) %>%
      filter(style == input$Style)
  })
}

shinyApp(ui, server)

library(tidyverse)

detailed_results <- fina_join()
detailed_results %>% group_by(series) %>% summarise(n = n())
detailed_results %>% group_by(style) %>% summarise(n = n())
detailed_results %>% group_by(distance) %>% summarise(n = n())
detailed_results %>% group_by(year) %>% summarise(n = n())
detailed_results %>% filter(year == 2020)
library(shiny)

ui <- fluidPage(sidebarLayout(
  sidebarPanel((selectizeInput("Competition",
                               label = "Choose the Competition",
                               choices = c("Champions Series", "Championships (25m)", "Championships (50m)", "Junior Championships", "Marathon Series", "Olympic Games", "World Cup", "Youth Olympic Games"))
                ),
  (radioButtons("Style",
                label = "Choose the Stroke",
                choices = c("Medley", "Backstroke", "Breaststroke", "Butterfly", "Freestyle"))),
  (sliderInput("Distance",
               label = "Select the Distance",
               min = 50,
               max = 1500,
               value = 100,
               step = 50)),
  (radioButtons("Relay",
                      label = "Relay?",
                      choices = c("TRUE", "FALSE"))),
  (numericInput("Year",
                label = "Select the Year",
                min = 1924,
                max = 2019,
                value = 2000,
                step = 1)),
  (radioButtons("Gender",
                label = "Gender",
                choices = c("Men", "Women")))),
  mainPanel(tabsetPanel(
    tabPanel("Rankings", tableOutput("place_table")),
    tabPanel("Tab 2", "contents"),
    tabPanel("Tab 3", "contents")
  ))
  
))
server <- function(input, output, session) {
  competition_name <- reactive({
    detailed_results %>% filter(series == input$Competition) %>%
      filter(style == input$Style) %>%
      filter(distance == input$Distance) %>%
      filter(relay == input$Relay) %>%
      filter(year == input$Year) %>%
      filter(gender == input$Gender)
  })
  output$place_table <- renderTable({
    competition_name() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, time)
  })
}

shinyApp(ui, server)
