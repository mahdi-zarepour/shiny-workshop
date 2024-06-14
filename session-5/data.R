library(shiny)


#---- 1. Uploading data from the user interface:
ui <- fluidPage(
  fileInput("upload", "Choose CSV File", accept = c(".csv", '.py', ".tsv")),
  
  tableOutput("head"),
)

server <- function(input, output) {
  dat <- reactive({
    req(input$upload)
    infile <- input$upload
    if (is.null(infile)) {
      return(NULL)
    }
    read.csv(infile$datapath, header = TRUE)
  })
  
  output$head = renderTable({
    head(dat())
  })
  
}

shinyApp(ui, server)


#--- 2. Loading data from a URL:
#--- A URL (Uniform Resource Locator) is the address of a unique 
# resource on the internet

ui <- fluidPage(
  numericInput("n", "Rows", value = 5, min = 1, step = 1),
  
  tableOutput("head")
)

server <- function(input, output){
  dat <- reactive({
    wli <- "https://raw.githubusercontent.com/selva86/datasets/master/"
    url = paste0(wli,"Carseats.csv")
    print('Loading...')
    read.csv(url)
    
    # read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/11-24-2020.csv")
    
  })
  
  output$head <- renderTable({
    head(dat(), input$n)
  })
}

shinyApp(ui, server)
