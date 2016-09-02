#coverage/inst/shiny/coverage1/ui.r
#andy south 12/5/16

library(shiny)


shinyUI(fluidPage(

  #can add CSS controls in here
  #http://shiny.rstudio.com/articles/css.html
  #http://www.w3schools.com/css/css_rwd_mediaqueries.asp
  tags$head(
    tags$style(HTML("

                    .col-sm-2 {padding: 80px 0px; /*border: 1px solid green;*/}

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

  h5("Vector control demonstrator prototype. Gerry Killeen & Andy South."),
  h5("Vectors feed indoors and outdoors, on humans and cattle. Interventions target a subset of these behaviours."),
  h5("Change inputs below to see implications."),

  fluidRow(
    column(8, plotOutput('plot_feed')),
    # column(2, h5("Vector feeding"), plotOutput('plot_pie_feed') ),
    # column(2, h5("Human exposure"), plotOutput('plot_pie_expose') )
    column(2, plotOutput('plot_pie_feed') ),
    column(2, plotOutput('plot_pie_expose') )

    # column(2, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_feed'), HTML("</div>")),
    # column(2, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_expose'), HTML("</div>"))

  ), #end fluid row


  #hr(),

  fluidRow(
    column(3,
           #h4("Vector feeding"),
           sliderInput("feed_man", "vectors feeding on man", 0.7, min = 0, max = 1, step = 0.1, ticks=FALSE)
           #numericInput("feed_cow", "cattle", 0.3, min = 0, max = 1, step = 0.1),
           #sliderInput("feed_in","indoor", 0.6, min = 0, max = 1, step = 0.1)
           #numericInput("feed_out","outdoor", 0.4, min = 0, max = 1, step = 0.1)
    ),
    column(3,
           sliderInput("feed_in","vectors feeding indoors", 0.6, min = 0, max = 1, step = 0.1, ticks=FALSE)
    ),
    column(3, offset = 0,
           #h4("Intervention"),
           radioButtons("intervention","intervention",choices=c("bed nets","vet insecticide"))
           #sliderInput("target_coverage", "coverage", 0.7, min = 0, max = 1, step = 0.1)
    ),
    column(3, offset = 0,
           sliderInput("target_coverage", "intervention coverage", 0, min = 0, max = 1, step = 0.1, ticks=FALSE)
    )
           # h4("Intervention target"),
           # numericInput("target_man", "human", 0.7, min = 0, max = 1, step = 0.1),
           # numericInput("target_cow", "cattle", 0.3, min = 0, max = 1, step = 0.1),
           # numericInput("target_in","indoor", 0.6, min = 0, max = 1, step = 0.1),
           # numericInput("target_out","outdoor", 0.4, min = 0, max = 1, step = 0.1)


  ) #end fluid row

))
