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

# Creating graph
output$attendances_chart = renderPlotly({
  
  ae_data_reactive() |> 
    plot_ly(x = ~week_ending_date,
            y = ~number_of_attendances_episode,
            type = "scatter", mode = "lines+markers")
  
})