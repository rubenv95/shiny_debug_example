####################### Page 1 #######################

output$page_1_ui <-  renderUI({

  div(
	     fluidRow(
            h3("A&E attendances"),
	           p("This is a chart showing the number of A&E attendances across health boards in Scotland"),
	           p(strong("Use the filters below to select a Health Board")),
            
            selectInput("ae_select_hb",
                        "Select a Health Board",
                        choices = hb_list)

	      ) #fluidrow
   ) # div
}) # renderUI


# Data table example
output$test_data_table <- DT::renderDataTable({
  make_table(datasets::mtcars, rows_to_display = 10)
})

# Plotly plot example
output$test_plot <- renderPlotly({
  mtcars_plot(datasets::mtcars)
})
