#coverage/inst/shiny/covmob1/server.r
#*deprecated replaved by coverage1*
#andy south 12/5/16

#https://andysouth.shinyapps.io/covmob1/

library(shiny)
#library(devtools)
#install_github('AndySouth/coverage')
library(coverage)
library(png)

shinyServer(function(input, output, session) {


  ################################
  output$plot_feed <- renderPlot({

    #add dependency on the button
    #if ( input$aButtonRun > 0 )
    #{
      #isolate reactivity of other objects
    #  isolate({

        plot_feeding( man = input$feed_man,
                      cow = 1-input$feed_man,
                      indoor = input$feed_in,
                      outdoor = 1-input$feed_in,
                      intervention = input$intervention,
                      coverage = input$target_coverage )


      #}) #end isolate
    #} #end if ( input$aButtonRun > 0 )
  })


  ####################################
  output$plot_pie_feed <- renderPlot(width = 150, height = 150,{

    plot_pie_feeding( man = input$feed_man,
                  cow = 1-input$feed_man,
                  indoor = input$feed_in,
                  outdoor = 1-input$feed_in,
                  intervention = input$intervention,
                  coverage = input$target_coverage )
  })


  ####################################
  output$plot_pie_expose <- renderPlot(width = 150, height = 150,{


    plot_pie_exposure(man = input$feed_man,
                      cow = 1-input$feed_man,
                      indoor = input$feed_in,
                      outdoor = 1-input$feed_in,
                      intervention = input$intervention,
                      coverage = input$target_coverage )
  })


  #to update values based on changes in others

  #stop feed_man going below feed_indoors
  #not needed now that human feed is a proportion of indoors
  #observe({ if ( input$feed_man < input$feed_in ) updateSliderInput(session, "feed_man", value = input$feed_in ) })

  #stop feedindoors going above feed_man
  # observe({ updateNumericInput(session, "feed_man", value = 1-input$feed_cow) })
  # observe({ updateNumericInput(session, "feed_cow", value = 1-input$feed_man) })
  # observe({ updateNumericInput(session, "feed_in", value = 1-input$feed_out) })
  # observe({ updateNumericInput(session, "feed_out", value = 1-input$feed_in) })


})
