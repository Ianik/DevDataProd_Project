library(shinydashboard)
library(dplyr)
library(ggplot2)
library(scales)
library(gridExtra)

# Read Data
data <- read.csv("data.csv", header = TRUE)

# Necessary transformations
data$Portfolio <-as.character(data$Portfolio)
data$Month <-as.Date(data$Month)
data<- tbl_df(data)

function(input, output) {
 
      # Small funtion used to transform the dataset
      
      updateDataset <- function(dt)
      {     
            
            # Select the right columns according to the figures selected
            # The figures column is then rename to have the same name
            
            if (input$figures=="Gross Losses") 
            {     dt <- select(dt,Portfolio,Year,Month,Value =Gross)
            }
      
            if (input$figures=="Credit") 
            {     dt <- select(dt,Portfolio,Year,Month, Value = Credit)
            }
      
            if (input$figures=="Net Losses") 
            {     dt <- select(dt,Portfolio,Year,Month,Value=Net)
            }
      
            # subset the dataset first by the Year then by the portfolio selected
            dt <- dt %>% subset(Year %in% input$years) %>% subset(Portfolio %in% input$portfolios)                     
      
           return(dt)
       }
          
          
          
      output$plot1 <- renderPlot({
            #Check that at least one portfolio is selected
            validate(
                  need(input$portfolios, 'Please choose at least one portfolio!')
            )
            
            # get the correct dataset
            dt<- updateDataset(data)
            
            # get min and max value for the y axis
            maxVal <- max(dt$Value)
            minVal <- min(dt$Value)
            if (minVal > 0) minVal<-0
                      
            # plot the graph
            print(ggplot(dt, aes(Month,Value,group=Portfolio,shape=Portfolio,color=Portfolio))
                                    + geom_line(size=1)
                                    + ggtitle(paste(input$figures,"Figures for",input$years))
                                    + xlab ("Month")
                                    + scale_x_date(labels = date_format("%b"),breaks = "1 month")
                                    + ylab ("Value (EUR)")
                                    + theme(legend.position="bottom")
                                    + scale_y_continuous(labels = comma,limit = c(minVal, maxVal)))
         
      })
           
}