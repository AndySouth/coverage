#coverage/inst/shiny/coverage1/ui.r
#andy south 12/5/16

library(shiny)


shinyUI(fluidPage(

  #can add CSS controls in here
  #http://shiny.rstudio.com/articles/css.html
  #http://www.w3schools.com/css/css_rwd_mediaqueries.asp
  tags$head(
    tags$style(HTML("

                    [class*='col-'] {
                    padding: 10px;
                    border: 1px;
                    position: relative;
                    min-height: 1px;
                    }

                    .container {
                    margin-right: 0;
                    margin-left: 0;
                    float: left;
                    }
                    .col-sm-1 {width: 8.33%; float: left;}
                    .col-sm-2 {width: 16.66%; float: left;}
                    .col-sm-3 {width: 25%; float: left;}
                    .col-sm-4 {width: 33.33%; float: left;}
                    .col-sm-5 {width: 41.66%; float: left;}
                    .col-sm-6 {width: 50%;  float: left;}
                    .col-sm-7 {width: 58.33%; float: left;}
                    .col-sm-8 {width: 66.66%; float: left; padding: 5px;} !to make more space for plots
                    .col-sm-9 {width: 75%; float: left;}
                    .col-sm-10 {width: 83.33%; float: left;}
                    .col-sm-11 {width: 91.66%; float: left;}
                    .col-sm-12 {width: 100%; float: left;}

                    "))
    ),

  title = "coverage of vector control interventions",

  h5("Vector control demonstrator prototype. Gerry Killeen & Andy South."),
  h5("Vectors feed indoors and outdoors, on humans and cattle. Interventions target a subset of these behaviours."),
  h5("Change inputs below to see implications."),

  # fluidRow(
  #   column(8, plotOutput('plot_feed')),
  #   # column(2, h5("Vector feeding"), plotOutput('plot_pie_feed') ),
  #   # column(2, h5("Human exposure"), plotOutput('plot_pie_expose') )
  #   column(2, plotOutput('plot_pie_feed') ),
  #   column(2, plotOutput('plot_pie_expose') )
  # ), #end fluid row

  fluidRow(
    column(12, plotOutput('plot_feed'))
  ), #end fluid row

  fluidRow(
    column(2,NULL),

    #column(4, plotOutput('plot_pie_feed') ),
    #column(4, plotOutput('plot_pie_expose') )

    column(4, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_feed'), HTML("</div>")),
    column(4, HTML("<div style='height: 150px;'>"), plotOutput('plot_pie_expose'), HTML("</div>"))

    #column(4, plotOutput('plot_pie_expose') )
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
