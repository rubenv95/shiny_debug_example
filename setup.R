####################### Setup #######################

# Shiny packages ----
library(shiny)
library(shinycssloaders)

# Data wrangling packages ----
library(dplyr)
library(magrittr)
library(janitor)
library(lubridate)

# Plotting packages ----
library(plotly)

# PHS packages ----
library(phsstyles)
library(phsopendata)


# Load core functions ----
source("functions/core_functions.R")

# Data ----
# Read in A&E data
ae_data = get_resource("a5f7ca94-c810-41b5-a7c9-25c18d43e5a4") |> 
  clean_names() |>
  # Renaming health board treatment to match to lookup
  rename(hb = hbt,
         # Hospital code rename to match lookup
         hospital_code = treatment_location)
# Read in health board reference file
hb_names = get_resource("652ff726-e676-4a20-abda-435b98dd7bdc") |> 
  clean_names()

# Hospital code and name reference file
hosp_names = get_resource("c698f450-eeed-41a0-88f7-c1e40a568acc") |> 
  clean_names() |> 
  select(1, 2)

# Matching health board name onto data and dropping unecessary columns
ae_data_tidy = ae_data |> 
  left_join(hb_names) |> 
  left_join(hosp_names) |> 
  select(-c(hb_date_enacted, hb_date_archived, country)) |> 
  # Tidying dates
  mutate(week_ending_date = ymd(week_ending_date))

# Aggregating to HB level
ae_data_hb = ae_data_tidy |> 
  group_by(week_ending_date, hb_name) |> 
  summarise(number_of_attendances_episode = sum(number_of_attendances_episode))

# Getting unique list of health boards for selectInput filter
hb_list = ae_data_tidy |> 
  arrange(hb_name) |> 
  distinct(hb_name) |> 
  pull(hb_name)

# Getting a list of hospital names, with health board too
hosp_list = ae_data_tidy |> 
  arrange(hospital_name) |> 
  distinct(hospital_name, hb_name, hb)


## Plotting ----
# Style of x and y axis
xaxis_plots <- list(title = FALSE, tickfont = list(size=14), titlefont = list(size=14),
                    showline = TRUE, fixedrange=TRUE)

yaxis_plots <- list(title = FALSE, rangemode="tozero", fixedrange=TRUE, size = 4,
                    tickfont = list(size=14), titlefont = list(size=14))

# Buttons to remove from plotly plots
bttn_remove <-  list('select2d', 'lasso2d', 'zoomIn2d', 'zoomOut2d',
                     'autoScale2d',   'toggleSpikelines',  'hoverCompareCartesian',
                     'hoverClosestCartesian')

# LOAD IN DATA HERE ----


