library(shiny)
library(ggplot2)


ui = fluidPage(
  titlePanel(
    title = 'Fluid row/Column'
  ),
  
  fluidRow(
    column(
      width = 4,
      numericInput('n1', 'your first num: ', min = 0, max = 100, value = 0)
    )
  ),
  
  fluidRow(
    column(
      width = 8,
      numericInput('n1', 'your second num: ', min = 0, max = 100, value = 0)
    )
  ),
  
  fluidRow(
    column(
      width = 10,
      selectInput('s1', 'choice: ', selected = 'A', choices = c('A', 'B'))
    ),
  ),
  
  fluidRow(
    column(
      width = 12,
      selectInput('s2', 'choice: ', selected = 'B', choices = c('A', 'B'))
    ),
  ),
  
  fluidRow(
    column(
      width = 12,
      dataTableOutput("df")
    )
  ),
  
  # add sidebar layout
  sidebarLayout(
    sidebarPanel(
      # inputs
      fluidRow(
        column(6,
               selectInput("x_var", "variables", choices = names(iris), selected = 'cyl'),
        ),
        column(6,
               selectInput("x_var", "variables", choices = names(iris), selected = 'cyl'))
      ),
      fluidRow(
        column(4,
               selectInput("x_var", "variables", choices = names(iris), selected = 'cyl'),
        ),
        column(4,
               selectInput("x_var", "variables", choices = names(iris), selected = 'cyl')
               ),
        column(4,
               selectInput("x_var", "variables", choices = names(iris), selected = 'cyl')
        ),
      ),
    ),
    mainPanel(
      # outputs
      fluidRow(
        column(6,
               tableOutput('df_1')       
        ),
        column(6,
               plotOutput('plot_1')       
        ),
      )
    )
  )
)

server = function(input, output, session) {
  output$df = renderDataTable(
    mtcars,
    options = list(pageLength = 10)
  )
  
  output$df_1 = renderTable(head(iris))
  
  output$plot_1 = renderPlot({
    hist(iris$Sepal.Length)
  })
}


shinyApp(ui = ui, server = server)