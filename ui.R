library(shiny)
library(shinydashboard)

# Load data used for selectInput controls
data <- read.csv("data.csv", header = TRUE)
data$Portfolio <- as.character(data$Portfolio)

dashboardPage(
      dashboardHeader(title = "Fraud Losses"),
      dashboardSidebar(disable = TRUE),
      dashboardBody(
            
            
            fluidRow(
                  
                  # First column
                  column(width=3,
                         
                         # First Box
                         box( width= NULL, status = "warning",
                              selectInput("years","Select Year:",
                                          choices = unique(data$Year),                                                     
                                          selected = "2015"),
                              
                              selectInput("figures","Select Figures:",
                                          choices = c("Gross Losses" = "Gross Losses",
                                                      "Credit" = "Credit",
                                                      "Net Losses" = "Net Losses"),
                                          selected= 1)
                              
                              ),
                         # Second Box
                         box( width= NULL, status= "warning",                                    
                                   
                                   
                                   checkboxGroupInput("portfolios","Select Portfolio(s):",
                                               choices = unique(data$Portfolio),
                                                selected = unique(data$Portfolio))
                              ),
                         
                         # Third Box with Text
                         box(width= NULL, status= "warning",                                    
                              
                             p(class = "text-muted",
                                paste("Note: Select the year and the type of figures (Gross Losses, Credits, Net Losses)",
                                       "you want to see and then choose the selected portfolio."))
                             )
                          
                                   
                              
                              
                        ),
                  
                  # Second Column
                  column(width = 9,
                              box(width=NULL, 
                                  plotOutput("plot1")
                                  )
                         )
                  
                  
                  
                  )
                  
      )
)
