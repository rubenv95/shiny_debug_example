####################### Core functions #######################

# Add n linebreaks
linebreaks <- function(n){HTML(strrep(br(), n))}

# Remove warnings from icons 
icon_no_warning_fn = function(icon_name) {
  icon(icon_name, verify_fa=FALSE)
}

# Generic data table
make_table <- function(input_data_table,
                       rows_to_display = 20
){
  
  # Take out underscores in column names for display purposes
  table_colnames  <-  gsub("_", " ", colnames(input_data_table))
  
  dt <- DT::datatable(input_data_table, style = 'bootstrap',
                      class = 'table-bordered table-condensed',
                      rownames = FALSE,
                      filter="top",
                      colnames = table_colnames,
                      options = list(pageLength = rows_to_display,
                                     scrollX = FALSE,
                                     scrollY = FALSE,
                                     dom = 'tip',
                                     autoWidth = TRUE,
                                     # style header
                                     initComplete = htmlwidgets::JS(
                                       "function(settings, json) {",
                                       "$(this.api().table().header()).css({'background-color': '#C5C3DA', 'color': '#3F3685'});",
                                       "$(this.api().table().row().index()).css({'background-color': '#C5C3DA', 'color': '#3F3685'});",
                                       "}")))
  
  
  return(dt)
}


bar_chart_function = function(data, x_col, y_col) {
  
  
  x_col = enquo(x_col)
  y_col = enquo(y_col)
  
  #browser()
  
  rlang::eval_tidy(
    rlang::quo_squash(quo(
      data |>
        plot_ly(
          x = ~!!x_col, y = ~!!y_col,
          type = 'bar', marker = list(
            color = phsstyles::phs_colors("phs-purple")),
          
        ) |>
        layout(
          xaxis = list(
            tickfont = list(size = 14),
            titlefont = list(size = 18)
          ),
          yaxis = list(
            categoryorder = "total ascending",
            tickfont = list(size=14),
            titlefont = list(size=18),
            showline = FALSE)
        ) |>
        config(displaylogo = F,
               displayModeBar = TRUE,
               modeBarButtonsToRemove = bttn_remove)
    )))
  
}


# Testing barchart function 
# ae_data_hb |> 
#   filter(week_ending_date == max(week_ending_date)) |> 
#   bar_chart_function(number_of_attendances_episode,
#                      hb_name)



line_chart_function = function(data, x_col, y_col, group_col) {
  
  
  x_col = enquo(x_col)
  y_col = enquo(y_col)
  group_col = enquo(group_col)
  
  palette = phs_colors(c("phs-purple", "phs-magenta", "phs-teal"))
  
  location_length = length(unique(data |> 
                                    pull(!!group_col)))
  
  
  rlang::eval_tidy(
    rlang::quo_squash(quo(
      data |>
        plot_ly(
          x = ~!!x_col, y = ~!!y_col, color = ~!!group_col,
          colors = palette[1:location_length],
          type = 'scatter', mode = "lines+markers") |>
        layout(
          xaxis = list(
            tickfont = list(size = 14),
            titlefont = list(size = 18)
          ),
          yaxis = list(
            tickfont = list(size=14),
            titlefont = list(size=18),
            showline = FALSE)
        ) |>
        config(displaylogo = F,
               displayModeBar = TRUE,
               modeBarButtonsToRemove = bttn_remove)
    )))
  
}


