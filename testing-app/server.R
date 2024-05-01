server <- function(input, output) {
  
  # Feature 1 ------------------------------------------------------------------
  
  # observe() automatically re-executes when dependencies change (i.e. when `name_input` is updated), but does not return a result ----
  observe({
    
    # if the user does not type anything before clicking the button, return the message, "Please type a name, then click the Greet button." ----
    if (nchar(input$name_input) == 0) {
      output$greeting_output <- renderText({
        "Please type a name, then click the Greet button."
      })
      
      # if the user does type a name before clicking the button, return the greeting, "Hello [name]!" ----
    } else {
      output$greeting_output <- renderText({
        paste0("Hello ", isolate(input$name_input), "!")
      })
    }
  }) |>
    
    # Execute the above observer once the button is pressed ----
  bindEvent(input$greeting_button_input)
  
  # Feature 2 ------------------------------------------------------------------
  
  # file upload ----
  output$summary_table_output <- renderTable({
    
    # NOTE: `input$csv_input` will be NULL initially
    # after user selects / uploads a file, it will be a df with 'name', 'size', 'type', 'datapath' cols
    # 'datapath' col will contain the local filenames where data can be found
    # see: https://shiny.posit.co/r/reference/shiny/1.4.0/fileinput
    
    # save input value to object named `inputFile` ----
    inputFile <- input$csv_input
    
    # if a file has not been uploaded yet, don't return / print anything ----
    if(is.null(inputFile))
      return(NULL)
    
    # read in file using it's datapath ----
    df_raw <- read_csv(inputFile$datapath)
    
    # validate that the uploaded CSV has the expected column names ----
    required_cols <- c("temp_c", "precip_cm", "wind_kmhr", "pressure_inhg")
    column_names <- colnames(df_raw)
    validate(
      need(all(required_cols %in% column_names), "Your CSV does not have the expected column headers.")
    )
    
    # return summarized data in a table ----
    df_summary <- df_raw |>
      summarize(
        avg_temp = mean(temp_c),
        avg_precip = mean(precip_cm),
        avg_wind = mean(wind_kmhr),
        avg_pressure = mean(pressure_inhg),
        tot_num_obs = length(temp_c)
      ) |>
      rename("Mean Temperature (C)" = "avg_temp",
             "Mean Precipitation (cm)" = "avg_precip",
             "Mean Wind Speed (km/hr)" = "avg_wind",
             "Mean Pressure (inHg)" = "avg_pressure",
             "Total Number of Observations" = "tot_num_obs")
    return(df_summary)
    
  })
  
} # END server