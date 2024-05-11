library(shiny)


ui = fluidPage(
  
  
)


server = function(input, output, session) {
  output$slider_out = renderText({
    input$slider
  })
}


shinyApp(ui = ui, server = server)


