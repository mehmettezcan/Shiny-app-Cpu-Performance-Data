library(shiny)

cpu_performance <- read.table(file = url("http://archive.ics.uci.edu/ml/machine-learning-databases/cpu-performance/machine.data"), sep=",")
colnames(cpu_performance) <-c("Vendor_Name","Model_Name","Machine_Cycle_Time","Minimum_Main_Memory","Maximum_Main_Memory",
                              "Cache_Memory","Minimum_Channels_Unit","Maximum_Channels_Unit",
                              "Published_Relative_Performance","Estimated_Relative_Performance")
cpu_performance$Vendor_Name <- as.character(cpu_performance$Vendor_Name)


ui <- fluidPage(
   
   
   titlePanel("Find Cpu Model and Vendor Name Using Cache Memory and Maximum Channels Unit"),
   
   
   sidebarLayout(
      sidebarPanel(
        selectInput("dataset1", "Choose a Cache Memory:", 
                    choices = sort(cpu_performance$Cache_Memory)),
        selectInput("dataset2", "Choose a Maximum Channels Unit:",
                    choices = sort(cpu_performance$Maximum_Channels_Unit))
      ),
      
      mainPanel(
        dataTableOutput("table")
      )
   )
)


server <- function(input, output) {
  
  output$table <- renderDataTable({
    data <- cpu_performance
    data <- data[data$Cache_Memory == input$dataset1,]
    data <- data[data$Maximum_Channels_Unit== input$dataset2,]
    c <- c(1,2)
    data[c]
  })
  
}

shinyApp(ui = ui, server = server)

