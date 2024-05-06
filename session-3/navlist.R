library(shiny)


# vertical navbar
ui = fluidPage(
  navlistPanel(
    id = 'nav_panel',
    'Head 1',
    navbarMenu('navbar menu 1',
      tabPanel(title = 'tab panel 1', value = 'Tab one'),
      tabPanel(title = 'tab panel 2', value = 'Tab Two'),
      tabPanelBody(value = 'tab panel body')
    ),
    'Head 2',
    navbarMenu('navbar menu 2',
               tabPanel(title = 'tab panel 3', value = 'Tab three'),
               tabPanel(title = 'tab panel 4', value = 'Tab four'),
               tabPanelBody(value = 'tab panel body')
    ),
    'Head 3',
    tabPanel('tab panel 5'),
    tabPanel('tab panel 6', value = 'tab 6 values', icon = icon('commenting'))
  )
)


server = function(input, output, session) {
  
}

shinyApp(ui = ui, server = server)