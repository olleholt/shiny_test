server <- function(input, output) {
  
  # Feature 1 ------------------------------------------------------------------
  
  output$greeting_output <- renderText({
    
    req(input$greeting_button_input) # req(): textOutput doesn't appear until button is first pressed
    paste0("Hello ", isolate(input$name_input), "!") # isolate(): prevents textOutput from updating until button is pressed again
    
  }) 
}
