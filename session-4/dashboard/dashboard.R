library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  
  
  dashboardHeader(
    title = 'Dashboard'
  ),
  
  
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data Frame", tabName = "data_frame", icon = icon("table")),
      menuItem("Plot", tabName = "plot", icon = icon("plot"))
    )
  ),

  
  dashboardBody(
    tabItems(
      tabItem(tabName = 'data_frame',
        fluidRow(
          box(
            tableOutput('data_frame')
          )
        )
      ),
      tabItem(tabName = 'plot',
        fluidRow(
          box(width = 4,
            sliderInput('plot_bins', 'number of bins', 0, 40, 15),
            radioButtons(
              'color', 'Histogram Colour', choices = 1:5, selected = 4
            )
          ),
          box(width = 8,
            plotOutput('plot')
          ),
          box(width = 4,
            plotOutput('plot1')
          ),
          box(width = 4,
            plotOutput('plot2')
          ),
          box(width = 4,
            plotOutput('plot3')
          ),
        )
      )
    )
  )
)


server <- function(input, output) {
  output$data_frame = renderTable({
    head(iris)
  })
  output$plot = renderPlot({
    hist(iris$Sepal.Length, input$plot_bins, col = input$color)
  })
  output$plot1 = renderPlot({
    boxplot(iris$Sepal.Length)
  })
  output$plot2 = renderPlot({
    plot(iris$Sepal.Length, iris$Sepal.Width)
  })
  output$plot3 = renderPlot({
    curve(dnorm(x, 2, 1), -6, 6)
  })
}


shinyApp(ui = ui, server = server)
