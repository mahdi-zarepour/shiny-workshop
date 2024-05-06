#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Import data", icon = icon('twitter'),
             fileInput("file", "Data", buttonLabel = "Upload..."),
             textInput("delim", "Delimiter (leave blank to guess)", ""),
             numericInput("skip", "Rows to skip", 0, min = 0),
             numericInput("rows", "Rows to preview", 10, min = 1)
    ),
    tabPanel("Set parameters",
             fluidRow(
               column(6,
                      selectInput('id', 'select', 0, 100, 40)
              ),
              column(6,
                     selectInput('id', 'select', 0, 100, 40)
              ),
              column(6,
                     selectInput('id', 'select', 0, 100, 40)
              ),
              column(6,
                     selectInput('id', 'select', 0, 100, 40)
              ),
              sidebarLayout(
                sidebarPanel(
                  sliderInput('id', 'select', 0, 20, 1)
                ),
                mainPanel(
                  h1('Main Panel')
                )
              )
             )
    ),
    tabPanel("Visualise results")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
