####################### Page 1 #######################

output$page_1_ui <-  renderUI({

  div(
	     fluidRow(
	           p("This tab shows number of A&E attendances across health boards in Scotland"),
	           p(strong("Use the filters below to select a Health Board")),
            
            selectInput("ae_select_hb",
                        "Select a Health Board",
                        choices = hb_list)

	      ) #fluidrow
   ) # div
}) # renderUI

