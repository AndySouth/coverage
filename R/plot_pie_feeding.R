#' plot pie of feeding
#'
#' plots vector feeding based on behaviour inputs
#'
#' @param man
#' @param cow
#' @param indoor
#' @param outdoor
#' @param intervene_indoor proportion coverage of intervention targetting indoor
#' @param intervene_cow proportion coverage of intervention targetting livestock
# @param intervention one of 'bed nets', 'vet insecticide'
# @param coverage target coverage of the chosen intervention (i.e. what proportion of it's target does it get)
#'
#' @return dataframe of some plot coords
#' @export

plot_pie_feeding <- function( man=NULL, cow=NULL, indoor=NULL, outdoor=NULL,
                              #intervention='bed nets', coverage=0.8,
                              intervene_indoor=0.8, intervene_cow=0,
                              col=c("deepskyblue", "orange", "yellow") )
  #intman=NULL, intcow=NULL, intindoor=NULL, intoutdoor=NULL )
{

  #set some defaults
  if (is.null(man) & is.null(cow) & is.null(indoor) & is.null(outdoor) )
  {
    man = 0.8
    cow = 0.2
    indoor = 0.3
    outdoor = 0.7
  }
  if (is.null(cow)  )
  {
    cow = 1-man
  }
  if (is.null(outdoor)  )
  {
    outdoor = 1-indoor
  }
  if (is.null(man)  )
  {
    man = 1-cow
  }
  if (is.null(indoor)  )
  {
    indoor = 1-outdoor
  }
  #add a check for if indoor>man
  #now that indoor is usd as prop of man this not needed
  # if (indoor > man)
  # {
  #   warning("biting indoor > human implies vectors are biting cattle indoors! exiting plot")
  #   return()
  # }


  #remove blank borders, bltr
  par(mar = c(0,0,1,0),oma = c(0, 0, 0, 0))

  #plot pie
  #pie(c(cow, man-indoor, indoor), col=df$z, labels=NA, main="Vector feeding", radius=1)

  cat("in pie_feeding man=",man," indoor=",indoor,"\n")

  # #including intervention
  # if (intervention == 'bed nets')
  # {
  #   #add intervention to end (man indoors)
  #   #pie(c(cow, man-indoor, indoor-(indoor*coverage)), col=c(df$z), labels=NA, main="", radius=1)
  #   #6/6/16 change now that indoor is a proportion of man
  #   #pie(c(1-man, man*(1-indoor), (man*indoor)-(man*indoor*coverage)), col=c(1:3), labels=NA, main="", radius=1)
  #   #8/6/16 set radius from proportion of max feeding
  #   pie(c(1-man, man*(1-indoor), (man*indoor)-(man*indoor*coverage)), col=col, labels=NA, main="", radius=1-(man*indoor*coverage), init.angle = 90)
  #
  # } else if (intervention == 'vet insecticide')
  # {
  #   #add intervention to start (cow)
  #   #pie(c(cow-(cow*coverage), man-indoor, indoor), col=c(df$z), labels=NA, main="", radius=1)
  #   #6/6/16 change now that indoor is a proportion of man
  #   #pie(c((1-man)-((1-man)*coverage), man*(1-indoor), man*indoor), col=c(1:3), labels=NA, main="", radius=1)
  #   #8/6/16 set radius from proportion of max feeding
  #   pie(c((1-man)-((1-man)*coverage), man*(1-indoor), man*indoor), col=col, labels=NA, main="", radius=1-(cow*coverage), init.angle = 90)
  # }

  # 9/9/16 should be able to replace the above with something more straightforward
  # subtract the interventions from the total before passing to the pie function
  # todo check this
  radius <- 1-((man*indoor*intervene_indoor) + (cow*intervene_cow))

  # combine two previous
  pie(c((1-man)-((1-man)*intervene_cow), man*(1-indoor), (man*indoor)-(man*indoor*intervene_indoor)), col=col, labels=NA, main="", radius=radius, init.angle = 90)


  #add a circle for if feeding was 100%
  symbols(x=0, y=0, circles=1, inches=FALSE, add=TRUE)

  #add title text
  mtext("Vector feeding", line=0)


  #this works to add the intervention as a blank, but isn't the way gerry does
  # if (intervention == 'bed nets')
  # {
  #   #add intervention to end (man indoors), see col too
  #   pie(c(cow, man-indoor, 1-(indoor*coverage), indoor*coverage), col=c(df$z,rgb(1,1,1,0.9)), labels=NA, main="Vector feeding", radius=1)
  # } else if (intervention == 'vet insecticide')
  # {
  #   #add intervention to start (cow)
  #   pie(c(cow*coverage, 1-(cow*coverage), man-indoor, indoor), col=c(rgb(1,1,1,0.9),df$z), labels=NA, main="Vector feeding", radius=1)
  # }



  #return plot coords in case needed
  invisible(df)

}
