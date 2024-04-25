library(shiny)
library(ggplot2)
library(glue)


ui <- fluidPage(
  # inputs, id and label without parameter name and other with parameter name
  textInput("text_input", "text input, enter your name: ", width = '800px', value = 'zzzz'),
  textAreaInput("text_area_input", "text area input", resize = 'vertical'),
  passwordInput("password_input", "password input"),
  numericInput("numeric_input", "numeric input", value = 100, min = 0, max = 2000, step = 100),
  sliderInput("slider_input", "slider input", value = 70, min = 0, max = 100),
  sliderInput("slider_input_range", "slider input with range",
    value = c(10, 50), min = 0, max = 100,
    step = 2, pre = "price", sep = ",",
  ),
  dateInput("date_input", "date input",
    format = "dd-mm-yyyy", language = "fa", weekstart = 6, min = '25-12-2022'
  ),
  dateRangeInput("date_range_input", "date range input"),
  selectInput("select_input", "select input",
    choices = c("A", "B", "C"), selected = "A", multiple = T
  ),
  radioButtons("radio_button", "radio button", choices = c("A", "B", "C"), selected = 'C'),
  checkboxInput("check_box_input", "check box input 1", value = F),
  checkboxInput("check_box_input", "check box input 2"),
  checkboxGroupInput("check_box_group_input", "check box group input",
    choices = c("A", "B", "C"), selected = 'B'
  ),
  fileInput("file_input", "file input"),
  actionButton("action_button", "action button",
    icon = icon(""),
    class = "btn-warning text-info"
  ),
  actionLink("action_link", "action link",
    icon = icon("fax"),
    class = "btn-danger btn-small btn-block"
  ),
  # outputs

  # Output regular text with textOutput()
  textOutput("text_output"),

  # console output with verbatimTextOutput()
  verbatimTextOutput("verbatim_output"),
  tableOutput("static_table"),
  dataTableOutput("dynamic_table"),
  plotOutput("plot_output", width = "400px", height = "500px"),
)


# render({}): for when have more than one line code

server <- function(input, output, session) {
  # pair for textOutput()
  output$text_output <- renderText({
    # use glue for f-string
    glue("hello {input$text_input}! (for text output)")
  })

  # pair for verbatimTextOutput()
  output$verbatim_output <- renderPrint(
    "hello body! (for verbatim output)"
  )

  output$static_table <- renderTable({
    mtcars
  })

  output$dynamic_table <- renderDataTable(
    mtcars,
    options = list(pageLength = 10)
  )

  output$plot_output <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point()
  })
}


shinyApp(ui = ui, server = server)
