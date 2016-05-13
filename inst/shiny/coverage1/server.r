#coverage/inst/shiny/coverage1/server.r
#andy south 12/5/16

library(shiny)
#install_github('AndySouth/coverage')
library(coverage)
library(png)

shinyServer(function(input, output, session) {


  output$plot_feed <- renderPlot({

    #add dependency on the button
    #if ( input$aButtonRun > 0 )
    #{
      #isolate reactivity of other objects
    #  isolate({

        #cat("running resistSimple with these inputs:", input$P_1, input$P_2*input$P_1, input$h.RS1_00, input$h.RS2_00,"\n")

        plot_feeding( man = input$feed_man,
                      cow = 1-input$feed_man,
                      indoor = input$feed_in,
                      outdoor = 1-input$feed_in,
                      intervention = input$intervention,
                      coverage = input$target_coverage )


      #}) #end isolate
    #} #end if ( input$aButtonRun > 0 )
  })


  #to update values based on changes in others
  # observe({ updateNumericInput(session, "feed_man", value = 1-input$feed_cow) })
  # observe({ updateNumericInput(session, "feed_cow", value = 1-input$feed_man) })
  # observe({ updateNumericInput(session, "feed_in", value = 1-input$feed_out) })
  # observe({ updateNumericInput(session, "feed_out", value = 1-input$feed_in) })


})
