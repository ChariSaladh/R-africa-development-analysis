library(shiny)
library(tidyverse)

africa <- read_csv("data/africa_gapminder.csv")

ui <- fluidPage(
  titlePanel("Life Expectancy and Income in Africa, 1952-2007"),
  sidebarLayout(
    sidebarPanel(
      selectInput("countries", "Choose countries:",
                  choices = sort(unique(africa$country)),
                  selected = c("Kenya", "Uganda", "Tanzania"),
                  multiple = TRUE),
      selectInput("metric", "Show:",
                  choices = c("Life expectancy" = "lifeExp",
                              "GDP per person" = "gdpPercap",
                              "Population" = "pop")),
      sliderInput("years", "Years:",
                  min = min(africa$year), max = max(africa$year),
                  value = c(min(africa$year), max(africa$year)),
                  step = 5, sep = "")
    ),
    mainPanel(
      plotOutput("trend"),
      tableOutput("latest")
    )
  )
)

server <- function(input, output) {
  
  chosen <- reactive({
    africa |>
      filter(country %in% input$countries,
             year >= input$years[1], year <= input$years[2])
  })
  
  output$trend <- renderPlot({
    req(nrow(chosen()) > 0)
    ggplot(chosen(), aes(x = year, y = .data[[input$metric]], colour = country)) +
      geom_line(linewidth = 1) +
      geom_point() +
      labs(x = NULL, y = names(which(c("Life expectancy" = "lifeExp",
                                       "GDP per person" = "gdpPercap",
                                       "Population" = "pop") == input$metric)),
           colour = "Country") +
      theme_minimal(base_size = 14)
  })
  
  output$latest <- renderTable({
    chosen() |>
      group_by(country) |>
      filter(year == max(year)) |>
      ungroup() |>
      transmute(Country = country,
                Year = as.character(year),
                `Life expectancy` = sprintf("%.1f", lifeExp),
                `GDP per person` = format(round(gdpPercap), big.mark = ","),
                Population = format(pop, big.mark = ","))
  })
}

shinyApp(ui, server)