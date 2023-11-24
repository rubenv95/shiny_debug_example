##########################################################
# shiny_app
# Original author(s): Ruben 
# Original date: 2023-11-24
# Written/run on RStudio server 2022.7.2.576.12 and R 4.1.2
# Description of content
##########################################################


# Get packages
source("setup.R")

# UI
ui <- fluidPage(
tagList(
# Specify most recent fontawesome library - change version as needed
tags$style("@import url(https://use.fontawesome.com/releases/v6.1.2/css/all.css);"),
navbarPage(
    id = "intabset", # id used for jumping between tabs
    title = div(
        tags$a(img(src = "phs-logo.png", height = 40),
               href = "https://www.publichealthscotland.scot/",
               target = "_blank"), # PHS logo links to PHS website
    style = "position: relative; top: -5px;"),
    windowTitle = "shiny_app",# Title for browser tab
    header = tags$head(includeCSS("www/styles.css"),  # CSS stylesheet
    tags$link(rel = "shortcut icon", href = "favicon_phs.ico") # Icon for browser tab
), ##############################################.
# INTRO PAGE ----
##############################################.
tabPanel(title = "Introduction",
    icon = icon_no_warning_fn("circle-info"),
    value = "intro",

    h1("Welcome to the dashboard"),
    uiOutput("intro_page_ui")

), # tabpanel
##############################################.
# PAGE 1 ----
##############################################.
tabPanel(title = "Page 1",
    # Look at https://fontawesome.com/search?m=free for icons
    icon = icon_no_warning_fn("stethoscope"),
    value = "intro",

    h1("Page 1 title"),
    uiOutput("page_1_ui"),
    linebreaks(2),
    h2("An example plot using mtcars data"),
    plotlyOutput("test_plot"),
    linebreaks(2),
    h2("An example data table using mtcars data"),
    DT::dataTableOutput("test_data_table"),
    linebreaks(2)

    ) # tabpanel
    ) # navbar
  ) # taglist
) # ui fluidpage

# ----------------------------------------------
# Server

server <- function(input, output, session) {

    # Get functions
    source(file.path("functions/core_functions.R"), local = TRUE)$value
    source(file.path("functions/intro_page_functions.R"), local = TRUE)$value
    source(file.path("functions/page_1_functions.R"), local = TRUE)$value

    # Get content for individual pages
    source(file.path("pages/intro_page.R"), local = TRUE)$value
    source(file.path("pages/page_1.R"), local = TRUE)$value

}

# Run the application
shinyApp(ui=ui, server=server)

### END OF SCRIPT ###