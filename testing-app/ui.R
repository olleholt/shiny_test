ui <- fluidPage(
  
  # Feature 1 ------------------------------------------------------------------
  
  h3("Feature 1"),
  
  # fluidRow (Feature 1: greeting) ----
  fluidRow(
    
    # greeting sidebarLayout ----
    sidebarLayout(
      
      # greeting sidebarPanel ----
      sidebarPanel(
        
        textInput(inputId = "name_input",
                  label = "What is your name?"),
        
        actionButton(inputId = "greeting_button_input",
                     label = "Greet"),
        
      ), # END greeting sidebarPanel
      
      # greeting mainPanel ----
      mainPanel(
        
        textOutput(outputId = "greeting_output"),
        
      ) # END greeting mainPanel
      
    ) # END greeting sidebarLayout
    
  ), # END fluidRow (Feature 1: greeting)
  
) # END fluidPage 