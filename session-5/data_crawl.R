library(shiny)
library(rvest)


doc = read_html('https://github.com/selva86/datasets')
a_tag = html_elements(doc, 'a.Link--primary')
csv_file_name = html_attr(a_tag[15:length(a_tag)-2], 'title')
csv_file_name = csv_file_name[endsWith(csv_file_name, '.csv')]
datasets = data.frame(title = csv_file_name)


ui <- fluidPage(
  numericInput("n", "Rows", value = 5, min = 1, step = 1),
  selectInput(
    'data_select', 'Select Dataset',
    choices = ''
  ),
  actionButton('submit', 'submit'),
  tableOutput("df_table")
)


server <- function(input, output, session) {
  
  observe({
    updateSelectInput(
      inputId='data_select',
      choices = datasets$title,
      selected = datasets$title[1]
    )
  })
  
  selected_df = eventReactive(input$submit, {
      print('loading ...')
      wli <- "https://raw.githubusercontent.com/selva86/datasets/master/"
      url = paste0(wli, input$data_select)
      read.csv(url)
  })
  
  output$df_table = renderTable({
    head(selected_df(), input$n)
  })
  
}


shinyApp(ui, server)
