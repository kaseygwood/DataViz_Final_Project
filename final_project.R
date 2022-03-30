library(tidyverse)
library(shiny)
library(plotly)

ui <- fluidPage(tabsetPanel(
  tabPanel("World Cup", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"), 
                             selected = "FALSE")),
               (selectizeInput("Year", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(1988:2019))),
               (radioButtons("Gender",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_worldcup")),
               tabPanel("Tab 2", plotlyOutput("timeplot_worldcup"))
             ))
             )
           ),
  tabPanel("Olympic Games", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style_o",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance_o",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay_o",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"),
                             selected = "FALSE")),
               (selectizeInput("Year_o", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(seq(1924, 2016, by = 4)))),
               (radioButtons("Gender_o",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_olympics")),
               tabPanel("Tab 2", plotlyOutput("timeplot_olympics"))
             )
           )
           )
  ),
  tabPanel("Championships (25m)", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style_c",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance_c",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay_c",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"), 
                             selected = "FALSE")),
               (selectizeInput("Year_c", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(1993, 1995, 1997, 1999, seq(2000, 2018, by = 2)))),
               (radioButtons("Gender_c",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_champion1")),
               tabPanel("Tab 2", plotlyOutput("timeplot_champion1"))
             ))
           )
  )
  ))
server <- function(input, output, session) {
  filtered_worldcup <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(style == input$Style) %>%
      filter(distance == input$Distance) %>%
      filter(relay == input$Relay) %>%
      filter(year == input$Year) %>%
      filter(gender == input$Gender)
  })
  filtered_olympics <- reactive({
    detailed_results %>% filter(series == "Olympic Games") %>%
      filter(style == input$Style_o) %>%
      filter(distance == input$Distance_o) %>%
      filter(relay == input$Relay_o) %>%
      filter(year == input$Year_o) %>%
      filter(gender == input$Gender_o)
  })
  filtered_champion1 <- reactive({
    detailed_results %>% filter(series == "Championships (25m)") %>%
      filter(style == input$Style_c) %>%
      filter(distance == input$Distance_c) %>%
      filter(relay == input$Relay_c) %>%
      filter(year == input$Year_c) %>%
      filter(gender == input$Gender_c)
  })
  output$place_table_worldcup <- renderTable({
    filtered_worldcup() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, time)
  })
  output$place_table_olympics <- renderTable({
    filtered_olympics() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, time)
  })
  output$place_table_champion1 <- renderTable({
    filtered_champion1() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, time)
  })
  time_plot_worldcup <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(gender == input$Gender) %>%
      filter(relay == input$Relay) %>%
      filter(distance == input$Distance) %>%
      filter(style == input$Style) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_worldcup_plotly <- reactive({
    ggplot(data = time_plot_worldcup(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_worldcup <- renderPlotly({
    ggplotly(time_plot_worldcup_plotly())
  })
  time_plot_olympics <- reactive({
    detailed_results %>% filter(series == "Olympic Games") %>%
      filter(gender == input$Gender_o) %>%
      filter(relay == input$Relay_o) %>%
      filter(distance == input$Distance_o) %>%
      filter(style == input$Style_o) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_olympics_plotly <- reactive({
    ggplot(data = time_plot_olympics(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_olympics <- renderPlotly({
    ggplotly(time_plot_olympics_plotly())
  })
  time_plot_champion1 <- reactive({
    detailed_results %>% filter(series == "Championships (25m)") %>%
      filter(gender == input$Gender_c) %>%
      filter(relay == input$Relay_c) %>%
      filter(distance == input$Distance_c) %>%
      filter(style == input$Style_c) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_champion1_plotly <- reactive({
    ggplot(data = time_plot_champion1(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_champion1 <- renderPlotly({
    ggplotly(time_plot_champion1_plotly())
  })
}

shinyApp(ui, server)
