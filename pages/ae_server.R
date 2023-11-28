####################### A&E Server #######################

# Setting up reactive dataset
ae_data_reactive = reactive({
  ae_data_tidy |> 
    filter(hb_name == input$ae_select_hb)
})

ae_data_agg_reactive = reactive({
  ae_data_hb |> 
    filter(hb_name == input$ae_select_hb)
})

# Creating HB graph
output$hb_attendances_chart = renderPlotly({
  
  ae_data_reactive() |> 
    plot_ly(x = ~week_ending_date,
            y = ~number_of_attendances_episode,
            type = "scatter", 
            mode = "lines+markers",
            marker = list(
              color = phs_colors("phs-purple")
            ),
            line = list(
              color = phs_colors("phs-purple")
            )) |> 
    layout(
      yaxis = list(
        title = "Number of attendances"
      ),
      xaxis = list(
        title = "Week ending"
      )
    ) |> 
    config(
      displaylogo = FALSE,
      displayModeBar = TRUE,
      modeBarButtonsToRemove = bttn_remove
    )
  
})



## Location Tab

output$input_hosp_ui = renderUI({
  
  if(input$hb_select_location == "Scotland") {
    location_list = hosp_list$hospital_name
  } else {
    location_list = hosp_list |> 
      filter(hb == input$hb_select_location)
  }
  
  selectizeInput("hosp_input_ae",
                 "Select locations to display (max 3)",
                 choices = location_list,
                 multiple = TRUE,
                 options = list(maxItems = 3,
                                plugins = list("remove_button")))
  
})

output$location_graph = renderPlotly({
  req(input$hosp_input_ae)
  
  chart_data = ae_data_tidy |> 
    filter(hospital_name %in% input$hosp_input_ae) |> 
    line_chart_function(week_ending_date, number_of_attendances_episode, 
                        hospital_name)

})