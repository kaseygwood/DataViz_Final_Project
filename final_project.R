library(tidyverse)
library(shiny)
library(plotly)
library(knitr)
library(shinythemes)
library(ggthemes)



detailed_results <- fina_join()


ui <- fluidPage(theme = shinytheme("superhero"),
                titlePanel("Professional Swimming Results"),
                tabsetPanel(
  tabPanel("World Cup", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            h4("Select the Event"),
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
                                            choices = c(1988:2019),
                                            selected = 2019)),
                            (radioButtons("Gender",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_worldcup"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_wc")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            h4("Select the Event"),
                            (radioButtons("Style_wc",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_wc",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_wc",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_wc",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(tableOutput("average_wc"),
                                    plotlyOutput("timeplot_worldcup")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_medal", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(1988:2019))),
                        tableOutput("country_medals_wc")))
             )
           )),
  tabPanel("Olympic Games", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
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
                                            choices = c(seq(1924, 2016, by = 4)),
                                            selected = 2016)),
                            (radioButtons("Gender_o",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_olympics"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_o")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            (radioButtons("Style_o_2",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_o_2",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_o_2",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_o_2",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(plotlyOutput("timeplot_olympics")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_o_medal", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(seq(1924, 2016, by = 4)))),
                        tableOutput("country_medals_o")))
             )
           )),
  tabPanel("Championships (25m)", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
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
                                            choices = c(1993, 1995, 1997, 1999, seq(2000, 2018, by = 2)),
                                            selected = 2018)),
                            (radioButtons("Gender_c",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_champion1"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_champion1")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            (radioButtons("Style_c_2",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_c_2",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_c_2",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_c_2",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(plotlyOutput("timeplot_champion1")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_medal_champion1", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(1993, 1995, 1997, 1999, seq(2000, 2018, by = 2)))),
                        tableOutput("country_medals_champion1")))
             )
           )),
  tabPanel("Championships (50m)", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
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
                                            choices = c(1973, 1975, 1978, 1982, 1986, 1991, 1994, 1998, seq(2001, 2019, by = 2)),
                                            selected = 2019)),
                            (radioButtons("Gender_cl",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_champion2"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_champion2")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            (radioButtons("Style_cl_2",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_cl_2",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_cl_2",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_cl_2",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(plotlyOutput("timeplot_champion2")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_medal_champion2", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(1973, 1975, 1978, 1982, 1986, 1991, 1994, 1998, seq(2001, 2019, by = 2)))),
                        tableOutput("country_medals_champion2")))
             )
           )),
  tabPanel("Junior Championships", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
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
                                            choices = c(2006, 2008, seq(2011, 2019, by = 2)),
                                            selected = 2019)),
                            (radioButtons("Gender_jc",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_jc"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_jc")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            (radioButtons("Style_jc_2",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_jc_2",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_jc_2",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_jc_2",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(plotlyOutput("timeplot_jc")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_medal_jc", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(2006, 2008, seq(2011, 2019, by = 2)))),
                        tableOutput("country_medals_jc")))
             )
           )),
  tabPanel("Youth Olympics", fluid = TRUE,
           verticalLayout(
             (tabsetPanel(
               tabPanel("Rankings", fluid = TRUE,
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
                                            choices = c(2010, 2014, 2018),
                                            selected = 2018)),
                            (radioButtons("Gender_yo",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(h3("Top Three Finishers"),
                                    tableOutput("place_table_youtholympics"),
                                    h3("Top Eight Finishers"),
                                    h5("time difference from first place finisher"),
                                    plotlyOutput("top8_plot_yo")))),
               tabPanel("Change in time over the years", fluid = TRUE,
                        sidebarLayout(
                          sidebarPanel(
                            (radioButtons("Style_yo_2",
                                          label = "Choose the Stroke",
                                          choices = c("Freestyle", "Backstroke", "Breaststroke", "Butterfly", "Medley"))),
                            (radioButtons("Distance_yo_2",
                                          label = "Select the Distance",
                                          choices = c("50", "100", "200", "400", "500", "1000", "1500"),
                                          selected = "100")),
                            (radioButtons("Relay_yo_2",
                                          label = "Relay?",
                                          choices = c("TRUE", "FALSE"),
                                          selected = "FALSE")),
                            (radioButtons("Gender_yo_2",
                                          label = "Gender",
                                          choices = c("Men", "Women")))),
                          mainPanel(plotlyOutput("timeplot_yo")))),
               tabPanel("Medals Won by Country Each Year", fluid = TRUE,
                        (selectizeInput("Year_medal_yo", ## fix the input choices here
                                        label = "Select the Year",
                                        choices = c(2010, 2014, 2018))),
                        tableOutput("country_medals_yo")))
              
             )
           ))
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
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank") %>%
      rename("Country" = "ioc_code") %>%
      rename("Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  output$place_table_olympics <- renderTable({
    filtered_olympics() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank",
             "Country" = "ioc_code",
             "Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  output$place_table_champion1 <- renderTable({
    filtered_champion1() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank",
             "Country" = "ioc_code",
             "Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  output$place_table_champion2 <- renderTable({
    filtered_champion2() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank",
             "Country" = "ioc_code",
             "Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  output$place_table_junior <- renderTable({
    filtered_junior() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank",
             "Country" = "ioc_code",
             "Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  output$place_table_youtholympics <- renderTable({
    filtered_youtholympics() %>% filter(phase_label == "Final") %>% 
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      select(rank, ioc_code, family_name, first_name, str_time) %>%
      rename("Place" = "rank",
             "Country" = "ioc_code",
             "Last Name" = "family_name",
             "First Name" = "first_name",
             "Time" = "str_time")
  })
  time_plot_worldcup <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(gender == input$Gender_wc) %>%
      filter(relay == input$Relay_wc) %>%
      filter(distance == input$Distance_wc) %>%
      filter(style == input$Style_wc) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size = 16,
                                family = "sans"))
  })
  output$timeplot_worldcup <- renderPlotly({
    ggplotly(time_plot_worldcup_plotly())
  })
  average_wc_df <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(gender == input$Gender_wc) %>%
      filter(relay == input$Relay_wc) %>%
      filter(distance == input$Distance_wc) %>%
      filter(style == input$Style_wc) %>%
      summarise(averagetime = mean(time, na.rm = TRUE))
  })
  output$average_wc <- renderTable({
    average_wc_df()
  })
  time_plot_olympics <- reactive({
    detailed_results %>% filter(series == "Olympic Games") %>%
      filter(gender == input$Gender_o_2) %>%
      filter(relay == input$Relay_o_2) %>%
      filter(distance == input$Distance_o_2) %>%
      filter(style == input$Style_o_2) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size=16,
                                family = "sans"),
            )
    
  })
  output$timeplot_olympics <- renderPlotly({
    ggplotly(time_plot_olympics_plotly())
  })
  time_plot_champion1 <- reactive({
    detailed_results %>% filter(series == "Championships (25m)") %>%
      filter(gender == input$Gender_c_2) %>%
      filter(relay == input$Relay_c_2) %>%
      filter(distance == input$Distance_c_2) %>%
      filter(style == input$Style_c_2) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size=16,
                                family  = "sans"))
  })
  output$timeplot_champion1 <- renderPlotly({
    ggplotly(time_plot_champion1_plotly())
  })
  time_plot_champion2 <- reactive({
    detailed_results %>% filter(series == "Championships (50m)") %>%
      filter(gender == input$Gender_cl_2) %>%
      filter(relay == input$Relay_cl_2) %>%
      filter(distance == input$Distance_cl_2) %>%
      filter(style == input$Style_cl_2) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size=16,
                                family = "sans"))
  })
  output$timeplot_champion2 <- renderPlotly({
    ggplotly(time_plot_champion2_plotly())
  })
  time_plot_junior <- reactive({
    detailed_results %>% filter(series == "Junior Championships") %>%
      filter(gender == input$Gender_jc_2) %>%
      filter(relay == input$Relay_jc_2) %>%
      filter(distance == input$Distance_jc_2) %>%
      filter(style == input$Style_jc_2) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size=16,
                                family = "sans"))
  })
  output$timeplot_jc <- renderPlotly({
    ggplotly(time_plot_junior_plotly())
  })
  time_plot_youtholympics <- reactive({
    detailed_results %>% filter(series == "Youth Olympic Games") %>%
      filter(gender == input$Gender_yo_2) %>%
      filter(relay == input$Relay_yo_2) %>%
      filter(distance == input$Distance_yo_2) %>%
      filter(style == input$Style_yo_2) %>%
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
      labs(x = "Year", y = "Average Time", title = "How The Average Swim Time Has Changed Over The Years") +
      theme(text = element_text(size=16,
                                family = "sans"))
  })
  output$timeplot_youtholympics <- renderPlotly({
    ggplotly(time_plot_youtholympics_plotly())
  })
  country_medals_df_o <- reactive({
    detailed_results %>% filter(series == "Olympic Games") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_o_medal) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_o <- renderTable({
    country_medals_df_o()
  })
  country_medals_df_wc <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_medal) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_wc <- renderTable({
    country_medals_df_wc()
  })
  country_medals_df_champion1 <- reactive({
    detailed_results %>% filter(series == "Championships (25m)") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_medal_champion1) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_champion1 <- renderTable({
    country_medals_df_champion1()
  })
  country_medals_df_champion2 <- reactive({
    detailed_results %>% filter(series == "Championships (50m)") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_medal_champion2) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_champion2 <- renderTable({
    country_medals_df_champion2()
  })
  country_medals_df_jc <- reactive({
    detailed_results %>% filter(series == "Junior Championships") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_medal_jc) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_jc <- renderTable({
    country_medals_df_jc()
  })
  country_medals_df_yo <- reactive({
    detailed_results %>% filter(series == "Youth Olympic Games") %>%
      filter(phase_label == "Final") %>%
      filter(rank == 1 | rank == 2 | rank == 3) %>%
      filter(year == input$Year_medal_yo) %>%
      group_by(ioc_code, rank) %>%
      summarise(medals = n()) %>%
      pivot_wider(names_from = rank,
                  values_from = medals) %>%
      mutate(gold = as.numeric(`1`),
             silver = as.numeric(`2`),
             bronze = as.numeric(`3`)) %>% 
      mutate(Gold = case_when(is.na(gold) ~ 0, !is.na(gold) ~ gold),
             Silver = case_when(is.na(silver) ~ 0, !is.na(silver) ~ silver),
             Bronze = case_when(is.na(bronze) ~ 0, !is.na(bronze) ~ bronze)) %>%
      mutate(totalmedals = Gold + Silver + Bronze) %>%
      select(ioc_code, Gold, Silver, Bronze, totalmedals) %>%
      arrange(desc(totalmedals)) %>%
      rename("Country" = "ioc_code",
             "Total Medals" = "totalmedals")
  })
  output$country_medals_yo <- renderTable({
    country_medals_df_yo()
  })
  top8_df_wc <- reactive({
    detailed_results %>% filter(series == "World Cup") %>%
      filter(gender == input$Gender) %>%
      filter(relay == input$Relay) %>%
      filter(distance == input$Distance) %>%
      filter(style == input$Style) %>%
      filter(year == input$Year) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind))) 
  })
  top8plotwc <- reactive({
    ggplot(data = top8_df_wc(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_wc <- renderPlotly({
    ggplotly(top8plotwc())
  })
  top8_df_o <- reactive({
    detailed_results %>% filter(series == "Olympic Games") %>%
      filter(gender == input$Gender_o) %>%
      filter(relay == input$Relay_o) %>%
      filter(distance == input$Distance_o) %>%
      filter(style == input$Style_o) %>%
      filter(year == input$Year_o) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind)))
  })
  
  top8ploto <- reactive({
    ggplot(data = top8_df_o(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                     family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_o <- renderPlotly({
    ggplotly(top8ploto())
  })
  top8_df_champion1 <- reactive({
    detailed_results %>% filter(series == "Championships (25m)") %>%
      filter(gender == input$Gender_c) %>%
      filter(relay == input$Relay_c) %>%
      filter(distance == input$Distance_c) %>%
      filter(style == input$Style_c) %>%
      filter(year == input$Year_c) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind)))
  })
  
  top8plotc <- reactive({
    ggplot(data = top8_df_champion1(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                     family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_champion1 <- renderPlotly({
    ggplotly(top8plotc())
  })
  top8_df_champion2 <- reactive({
    detailed_results %>% filter(series == "Championships (50m)") %>%
      filter(gender == input$Gender_cl) %>%
      filter(relay == input$Relay_cl) %>%
      filter(distance == input$Distance_cl) %>%
      filter(style == input$Style_cl) %>%
      filter(year == input$Year_cl) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind)))
  })
  
  top8plotc2 <- reactive({
    ggplot(data = top8_df_champion2(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                     family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_champion2 <- renderPlotly({
    ggplotly(top8plotc2())
  })
  top8_df_jc <- reactive({
    detailed_results %>% filter(series == "Junior Championships") %>%
      filter(gender == input$Gender_jc) %>%
      filter(relay == input$Relay_jc) %>%
      filter(distance == input$Distance_jc) %>%
      filter(style == input$Style_jc) %>%
      filter(year == input$Year_jc) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind)))
  })
  
  top8plotjc <- reactive({
    ggplot(data = top8_df_jc(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                     family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_jc <- renderPlotly({
    ggplotly(top8plotjc())
  })
  top8_df_yo <- reactive({
    detailed_results %>% filter(series == "Youth Olympic Games") %>%
      filter(gender == input$Gender_yo) %>%
      filter(relay == input$Relay_yo) %>%
      filter(distance == input$Distance_yo) %>%
      filter(style == input$Style_yo) %>%
      filter(year == input$Year_yo) %>%
      filter(phase_label == "Final") %>%
      arrange(desc(phase_label)) %>%
      slice(1:8) %>%
      mutate(timebehind = case_when(is.na(time_behind) ~ "0", 
                                    !is.na(time_behind) ~ time_behind)) %>%
      mutate(name_ordered = fct_reorder(.f = family_name, .x = desc(timebehind)))
  })
  
  top8plotyo <- reactive({
    ggplot(data = top8_df_yo(), aes(x = name_ordered, y = timebehind, fill = ioc_code)) +
      geom_col() +
      coord_flip() +
      labs(x = "Swimmer",
           y = "Time Behind",
           fill = "Country") +
      theme(axis.text = element_text(size = 10,
                                     family = "sans"),
            axis.title = element_text(size = 16,
                                      family = "sans"),
            text = element_text(family = "sans"))
  })
  output$top8_plot_yo <- renderPlotly({
    ggplotly(top8plotyo())
  })
}

shinyApp(ui, server)
