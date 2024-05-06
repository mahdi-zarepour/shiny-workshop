library(shiny)
library(ggplot2)


ui = fluidPage(
  # html theme, use bootswatch for select theme
  theme = bslib::bs_theme(bootswatch = "morph"),
  
  titlePanel("A themed plot"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30)
    ),
    mainPanel(
      h1(paste0("Theme: darkly")),
      h2("Header 2"),
      p("Some text"),
      plotOutput("plot"),
    )
  )
)


server = function(input, output, session) {
  # plot theme
  thematic::thematic_shiny()
  
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point() +
      geom_smooth()
  }, res = 96)
}


shinyApp(ui = ui, server = server)