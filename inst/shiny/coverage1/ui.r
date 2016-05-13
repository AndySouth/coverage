#coverage/inst/shiny/coverage1/ui.r
#andy south 12/5/16

library(shiny)


shinyUI(fluidPage(

  title = "coverage of vector control interventions",

  h4("Coverage of vector control interventions is dependent on vector behaviour"),
  h4("Vectors feed indoors and outdoors, on humans and cattle. Interventions target a subset of these behaviours."),
  h4("Change inputs below to see the implications."),

  fluidRow(
    column(8, plotOutput('plot_feed'))
    #column(6, plotOutput('plot'))
  ), #end fluid row

  hr(),

  #h4("Curtis' input values are indicated in bold"),

  fluidRow(
    column(3,
           h4("Vector feeding"),
           numericInput("feed_man", "human", 0.7, min = 0, max = 1, step = 0.1),
           #numericInput("feed_cow", "cattle", 0.3, min = 0, max = 1, step = 0.1),
           numericInput("feed_in","indoor", 0.6, min = 0, max = 1, step = 0.1)
           #numericInput("feed_out","outdoor", 0.4, min = 0, max = 1, step = 0.1)
           #numericInput("P_2", "locus2 - proportion of locus1:", 0.1, min = 0.01, max = 100, step = 0.01)
    ),
    column(3, offset = 0,
           h4("Intervention"),
           numericInput("target_coverage", "coverage", 0.7, min = 0, max = 1, step = 0.1),
           radioButtons("intervention","intervention type",choices=c("bed nets","vet insecticide"))
           # h4("Intervention target"),
           # numericInput("target_man", "human", 0.7, min = 0, max = 1, step = 0.1),
           # numericInput("target_cow", "cattle", 0.3, min = 0, max = 1, step = 0.1),
           # numericInput("target_in","indoor", 0.6, min = 0, max = 1, step = 0.1),
           # numericInput("target_out","outdoor", 0.4, min = 0, max = 1, step = 0.1)
    )

  ), #end fluid row
  fluidRow(
    column(4, hr())
    #column(2, actionButton('aButtonRun', 'Run Model'))
  ) #end fluid row
))
