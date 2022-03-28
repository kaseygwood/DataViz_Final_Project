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
  (radioButtons("Distance",
               label = "Select the Distance",
               choices = c("50", "100", "200", "400", "500", "1000", "1500"))),
  (radioButtons("Relay",
                label = "Relay?",
                choices = c("TRUE", "FALSE"))),
  (selectizeInput("Year", ## fix the input choices here
                label = "Select the Year",
                choices = c("2008", "2004", "2000"))),
  (radioButtons("Gender",
                label = "Gender",
                choices = c("Men", "Women")))),
  mainPanel(tabsetPanel(
    tabPanel("Rankings", tableOutput("place_table")),
    tabPanel("Tab 2", plotOutput("timeplot")),
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
  time_plot <- reactive({
    test <- detailed_results %>% filter(series == input$Competition) %>%
      filter(gender == input$Gender) %>%
      filter(relay == input$Relay) %>%
      filter(distance == input$Distance) %>%
      filter(style == input$Style) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time),
                se = sd(time)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
    ggplot(data = test, aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se))
  })
  output$timeplot <- renderPlot({
    time_plot()
  })
}

shinyApp(ui, server)
## create a new data set for each competition
## is there a way to make inputs reactive