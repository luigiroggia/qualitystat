library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Control Charts and Capability Analysis"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the
        # br() element to introduce extra vertical spacing
        sidebarLayout(
                sidebarPanel(
                        
                        numericInput("mean", "Mean", value="3"),
                        
                        numericInput("sd", "Standard deviation", value="0.7"),
                        
                        sliderInput("n", 
                                    "Number of samplings:", 
                                    value = 20,
                                    min = 5, 
                                    max = 50),
                        
                        selectInput("sizes", "Measurements per sampling:",
                                    c("One"=1,"Two"=2,"Five"=5,"Ten"=10)),
                        
                        br(),
                        br(),
                        
                        numericInput("lsl", "LSL", value=""),
                        
                        numericInput("usl", "USL", value=""),
                        
                        numericInput("target", "Target value", value="")
                ),
                
                # Show a tabset that includes a plot, summary, and table view
                # of the generated distribution
                mainPanel(
                        tabsetPanel(type = "tabs", 
                                    tabPanel("Welcome", htmlOutput("welcome")),
                                    tabPanel("Control Charts", plotOutput("main.chart"),plotOutput("aux.chart")), 
                                    tabPanel("Capability", plotOutput("capability")), 
                                    tabPanel("Descriptive Statistics", verbatimTextOutput("summary")), 
                                    tabPanel("Data", tableOutput("table"))
                        )
                )
        )
))
