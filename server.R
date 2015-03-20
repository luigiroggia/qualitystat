library(shiny)
library(qcc)

# Define server 
shinyServer(function(input, output) {
        
       
        # Generate some random data from a normal distribution
        # numerosity, mean and standard deviation are from user inputs
        # If we have subgroups size = 1 (that is, no subgroups), then we will have a single column
        # If we have m subgroups, then we will have m columns in the data frame
        # Subgroups are recorded by rows (if any subgroup)
        data <- reactive({
                
                m <- matrix(rnorm(input$n*as.numeric(input$sizes),
                                  mean=input$mean,
                                  sd=input$sd),
                            ncol=as.numeric(input$sizes),
                            nrow=input$n)
                data.frame(m)
                

        })
        
        # Generate a control chart for individual values, when subgroup size equals one
        # or generate a Xbar control chart when you have subgroups
        output$main.chart <- renderPlot({
               
                if (1 == as.numeric(input$sizes)) {
                        obj<-qcc(data(),
                                 type="xbar.one",
                                 title="Indivudual Values Chart for Data")
                }
                 
                else {
                        obj<-qcc(data(),
                                 type="xbar",
                                 title="Xbar Chart for Data", 
                                 sizes=as.numeric(input$sizes))      
                }       

        })
        
        # If you have subgroups, then create an auxiliary control chart which will let you
        # understand if the Xbar chart is reliable
        # We will have a R chart when subgroup size is less than 9
        # else a S chart when size is greater than 8
        output$aux.chart <- renderPlot({
                
                if (as.numeric(input$sizes) > 1 && as.numeric(input$sizes) < 9) {
                        obj<-qcc(data(),
                                 type="R",
                                 title="R Chart for Data",
                                 sizes=as.numeric(input$sizes))
                }
                
                else if (as.numeric(input$sizes) > 8) {
                        obj<-qcc(data(),
                                 type="S",
                                 title="S Chart for Data",
                                 sizes=as.numeric(input$sizes))
                }    
                
                else {
                        # do nothing
                }
                
        })
        
        output$capability <- renderPlot({
                
                # Lower and upper specification limits are required
                # If the user has provided some values, then we use those values
                # Else we assume 3 standard deviations
                # If the target value is not given, then we assume it is in the middle
                # between lsl and usl
                if (is.numeric(input$lsl)) {lsl = input$lsl} else {lsl = input$mean-3*input$sd}
                if (is.numeric(input$usl)) {usl = input$usl} else {usl = input$mean+3*input$sd}
                if (is.numeric(input$target)) {target = input$target} else {target = (lsl+usl)/2}
                
                # First we need a control chart to run a capability analysis
                if (1 == as.numeric(input$sizes)) {  
                        obj<-qcc(data(),type="xbar.one")
                }
                
                else {  
                        obj<-qcc(data(),
                                 type="xbar",
                                 sizes=as.numeric(input$sizes))
                } 
                
                # Then we can have our capability
                process.capability(obj,
                                   spec.limits=c(lsl,usl),
                                   target= target)
                
                
        })
        
        # Generate a summary of the simulated data
        output$summary <- renderPrint({
                summary(data())
        })
        
        # Generate a view of your simulated data 
        output$table <- renderTable({
                data.frame(x=data())
        })
        
        # Generate the welcome tab
        output$welcome <- renderText({
                
                paste(
                
                tags$br(),
                tags$h3("Quality Analysis Simulator"),
                tags$br(),
                tags$br(),
                tags$div("Use this application to simulate quality statistics analysis for your process"),
                tags$br(),
                tags$br(),
                tags$ul(
                        tags$li("Simulate from 5 to 50 samplings, based on your historical mean and standard devaition"),
                        tags$li("Select the number of measurements for each sampling (subgroup size)"),
                        tags$li("Give LSL, USL and target for capability analysis"),
                        tags$li("See what would happen with your control charts and capability"),
                        tags$li("have fun changing your settings..!")
                        ),
                tags$br(),
                tags$br(),
                tags$div(tags$span("This simulator is by Luigi Roggia, data scientist @ "),
                        tags$a(href="http://www.kiwidatascience.com","Kiwi Data Science"))
                )
        })
        
})
