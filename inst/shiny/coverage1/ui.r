#coverage/inst/shiny/coverage1/ui.r
#*this is current version, resizes to browser & mob
#andy south 16/9/16

library(shiny)
library(markdown)

shinyUI(fluidPage(

  #can add CSS controls in here
  #http://shiny.rstudio.com/articles/css.html
  #http://www.w3schools.com/css/css_rwd_mediaqueries.asp
  tags$head(
    tags$style(HTML("

                    ! .col-sm-2 {padding: 80px 0px; /*border: 1px solid green;*/}
                    /*.col-sm-2.4 {width: 20%; float: left;}*/

                    /* For mobile phones: */
                    /* note here I'm not following mobile first design ! */
                    @media only screen and (max-width: 768px) {


                        [class*='col-'] {
                        padding: 5px;
                        border: 1px;
                        position: relative;
                        min-height: 1px;
                        }

                        .container {
                        margin-right: 0;
                        margin-left: 0;
                        float: left;
                        }
                        .col-sm-2 {width: 50%; float: left; height: 150px;}
                        .col-sm-3 {width: 25%; float: left;}
                        .col-sm-8 {width: 100%; float: left; height: 350px;} ! padding: 5px;} !to make more space for plots
                        ! so on pc the where the css doesn't kick in the 12 columns fit in one row (8+2+2)
                        ! on the phone the width8 col takes up 100%, and the width2 columns take up 50% of the next row
                        }

                    "))
    ),

  title = "coverage of vector control interventions",

  #7/10/16
  #navbarPage sets up navbar, title appears on left
  navbarPage("vector control graphical model", id="selectedTab",

     # tab "seek stable mortality" ---------------------------
     tabPanel("UI", value="seek",
  #7/10/16

  #h5("Vector control demonstrator. Andy South & Gerry Killeen."),
  h5("Interventions target a subset of vectors which feed indoors and outdoors, on humans and cattle. Modify inputs to see the implications."),

  fluidRow(
    column(4, h4("Vector feeding : ")),
    column(6, h4("Intervention coverage : "))
  ), #end fluid row

  fluidRow(
    column(2,
           sliderInput("feed_man", NULL, 0.7, min = 0, max = 1, step = 0.1, ticks=FALSE),
           h5("on humans")
    ),
    column(2,
           sliderInput("feed_in",NULL, 0.6, min = 0, max = 1, step = 0.1, ticks=FALSE),
           h5("indoors (of human feeders)")

    ),
    column(2, offset = 0,
           sliderInput("intervene_indoor", NULL, 0, min = 0, max = 1, step = 0.1, ticks=FALSE),
           h5("insecticidal bed net")

    ),
    column(2, offset = 0,
           sliderInput("intervene_outdoor", NULL, 0, min = 0, max = 1, step = 0.1, ticks=FALSE),
           h5("outdoor vapour insecticide emanator")
    ),
    column(2, offset = 0,
           sliderInput("intervene_cow", NULL, 0, min = 0, max = 1, step = 0.1, ticks=FALSE),
           h5("veterinary insecticide")
    )
    # h4("Intervention target"),
    # numericInput("target_man", "human", 0.7, min = 0, max = 1, step = 0.1),
    # numericInput("target_cow", "cattle", 0.3, min = 0, max = 1, step = 0.1),
    # numericInput("target_in","indoor", 0.6, min = 0, max = 1, step = 0.1),
    # numericInput("target_out","outdoor", 0.4, min = 0, max = 1, step = 0.1)

  ), #end fluid row

  fluidRow(
    column(8, plotOutput('plot_feed')),
    column(2, hr(), h5("Vector blood sources"), plotOutput('plot_pie_feed') ),
    column(2, hr(), h5("Human exposure"), plotOutput('plot_pie_expose') )
    #column(2, plotOutput('plot_pie_feed') ),
    #column(2, plotOutput('plot_pie_expose') )

    # column(2, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_feed'), HTML("</div>")),
    # column(2, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_expose'), HTML("</div>"))

  ) #end fluid row


  #hr(),


#7/10/16
  ), # end tabPanel("UI")
  # tab "About" ---------------------------
  tabPanel("About", includeMarkdown("about.md"))

  ) # end navbarPage
#7/10/16

))
