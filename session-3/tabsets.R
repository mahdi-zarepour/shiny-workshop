library(shiny)
library(ggplot2)


ui = fluidPage(
  h1(textOutput('current_tab')),
  tabsetPanel(
    id = 'tabset_panel',
    tabPanel(
      title = 'Tab 1/mtcars dataset',
      dataTableOutput('mtcars_df')
    ),
    tabPanel(
      title = 'Tab 2/iris dataset',
      dataTableOutput('iris_df')
    ),
    tabPanel(
      title = 'Tab 3/plots',
      sidebarLayout(
        sidebarPanel(
          selectInput('select_df', 'choose dataset:', choices = c('mtcars', 'iris'), selected = 'mtcars'),
        ),
        mainPanel(
          plotOutput('plot_df')
        )
      )
    )
  )
)


server = function(input, output, session) {
  output$current_tab = renderText(
    paste("Current panel: ", input$tabset_panel)
  )
  
  output$mtcars_df = renderDataTable(
    mtcars,
    options = list(pageLength = 10)
  )
  
  output$iris_df = renderDataTable(
    iris,
    options = list(pageLength = 10)
  )
  
  
  output$plot_df = renderPlot({
    if (input$select_df == 'mtcars') {
      ggplot(mtcars, aes(x=cyl)) +
        geom_bar()
    } else {
      ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
        geom_point()
    }
  })
}


shinyApp(ui = ui, server = server)