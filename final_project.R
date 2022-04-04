library(tidyverse)
library(shiny)
library(plotly)

detailed_results <- fina_join()

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
               tabPanel("Change Over Time", plotlyOutput("timeplot_worldcup"))
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
               tabPanel("Change Over Time", plotlyOutput("timeplot_olympics"))
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
               tabPanel("Change Over Time", plotlyOutput("timeplot_champion1"))
             ))
           )
  ),
  tabPanel("Championships (50m)", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style_cl",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance_cl",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay_cl",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"), 
                             selected = "FALSE")),
               (selectizeInput("Year_cl", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(1973, 1975, 1978, 1982, 1986, 1991, 1994, 1998, seq(2001, 2019, by = 2)))),
               (radioButtons("Gender_cl",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_champion2")),
               tabPanel("Change Over Time", plotlyOutput("timeplot_champion2"))
             ))
           )
  ),
  tabPanel("Junior Championships", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style_jc",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance_jc",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay_jc",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"), 
                             selected = "FALSE")),
               (selectizeInput("Year_jc", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(2006, 2008, seq(2011, 2019, by = 2)))),
               (radioButtons("Gender_jc",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_junior")),
               tabPanel("Change Over Time", plotlyOutput("timeplot_junior"))
             ))
           )
  ),
  tabPanel("Youth Olympic Games", fluid = TRUE,
           sidebarLayout(
             sidebarPanel(
               (radioButtons("Style_yo",
                             label = "Choose the Stroke",
                             choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
               (radioButtons("Distance_yo",
                             label = "Select the Distance",
                             choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                             selected = "100")),
               (radioButtons("Relay_yo",
                             label = "Relay?",
                             choices = c("TRUE", "FALSE"), 
                             selected = "FALSE")),
               (selectizeInput("Year_yo", ## fix the input choices here
                               label = "Select the Year",
                               choices = c(2010, 2014, 2018))),
               (radioButtons("Gender_yo",
                             label = "Gender",
                             choices = c("Men", "Women")))),
             mainPanel(tabsetPanel(
               tabPanel("Rankings", tableOutput("place_table_youtholympics")),
               tabPanel("Change Over Time", plotlyOutput("timeplot_youtholympics"))
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
  filtered_champion2 <- reactive({
    detailed_results %>% filter(series == "Championships (50m)") %>%
      filter(style == input$Style_cl) %>%
      filter(distance == input$Distance_cl) %>%
      filter(relay == input$Relay_cl) %>%
      filter(year == input$Year_cl) %>%
      filter(gender == input$Gender_cl)
  })
  filtered_junior <- reactive({
    detailed_results %>% filter(series == "Junior Championships") %>%
      filter(style == input$Style_jc) %>%
      filter(distance == input$Distance_jc) %>%
      filter(relay == input$Relay_jc) %>%
      filter(year == input$Year_jc) %>%
      filter(gender == input$Gender_jc)
  })
  filtered_youtholympics <- reactive({
    detailed_results %>% filter(series == "Youth Olympic Games") %>%
      filter(style == input$Style_yo) %>%
      filter(distance == input$Distance_yo) %>%
      filter(relay == input$Relay_yo) %>%
      filter(year == input$Year_yo) %>%
      filter(gender == input$Gender_yo)
  })
  output$place_table_worldcup <- renderTable({
    filtered_worldcup() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
  })
  output$place_table_olympics <- renderTable({
    filtered_olympics() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
  })
  output$place_table_champion1 <- renderTable({
    filtered_champion1() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
  })
  output$place_table_champion2 <- renderTable({
    filtered_champion2() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
  })
  output$place_table_junior <- renderTable({
    filtered_junior() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
  })
  output$place_table_youtholympics <- renderTable({
    filtered_youtholympics() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time)
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
  time_plot_champion2 <- reactive({
    detailed_results %>% filter(series == "Championships (50m)") %>%
      filter(gender == input$Gender_cl) %>%
      filter(relay == input$Relay_cl) %>%
      filter(distance == input$Distance_cl) %>%
      filter(style == input$Style_cl) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_champion2_plotly <- reactive({
    ggplot(data = time_plot_champion2(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_champion2 <- renderPlotly({
    ggplotly(time_plot_champion2_plotly())
  })
  time_plot_junior <- reactive({
    detailed_results %>% filter(series == "Junior Championships") %>%
      filter(gender == input$Gender_jc) %>%
      filter(relay == input$Relay_jc) %>%
      filter(distance == input$Distance_jc) %>%
      filter(style == input$Style_jc) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_junior_plotly <- reactive({
    ggplot(data = time_plot_junior(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_junior <- renderPlotly({
    ggplotly(time_plot_junior_plotly())
  })
  time_plot_youtholympics <- reactive({
    detailed_results %>% filter(series == "Youth Olympic Games") %>%
      filter(gender == input$Gender_yo) %>%
      filter(relay == input$Relay_yo) %>%
      filter(distance == input$Distance_yo) %>%
      filter(style == input$Style_yo) %>%
      group_by(year) %>%
      summarise(averagetime = mean(time, na.rm = TRUE),
                se = sd(time, na.rm = TRUE)/sqrt(100),
                l_se = averagetime - se,
                u_se = averagetime + se)
  })
  time_plot_youtholympics_plotly <- reactive({
    ggplot(data = time_plot_youtholympics(), aes(x = year, y = averagetime)) +
      geom_point() +
      geom_errorbar(aes(ymin = l_se, ymax = u_se)) +
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years")
  })
  output$timeplot_youtholympics <- renderPlotly({
    ggplotly(time_plot_youtholympics_plotly())
  })
}

shinyApp(ui, server)
