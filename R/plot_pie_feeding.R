#' plot pie of feeding
#'
#' plots vector feeding based on behaviour inputs
#'
#' @param man proportion of indoor mosquitoes feeding on man
#' @param cow proportion of outdoor mosquitoes feeding on livestock
#' @param indoor proportion of mosquitoes feeding indoors
# @param outdoor
#' @param intervene_indoor proportion coverage of intervention targetting indoor
#' @param intervene_cow proportion coverage of intervention targetting livestock
#' @param intervene_outdoor proportion coverage of intervention targetting outdoor
# @param intervention one of 'bed nets', 'vet insecticide'
# @param coverage target coverage of the chosen intervention (i.e. what proportion of it's target does it get)
#'
#' @examples
#' plot_pie_feeding(man=0.5, indoor=0.7, intervene_indoor=0.5)
#'
#' @return dataframe of some plot coords
#' @export

plot_pie_feeding <- function( man=NULL, cow=NULL, indoor=NULL,
                              #outdoor=NULL,
                              #intervention='bed nets', coverage=0.8,
                              intervene_indoor=0.8, intervene_cow=0,
                              intervene_outdoor=0.2,
                              col=c("deepskyblue", "orange", "yellow") )
  #intman=NULL, intcow=NULL, intindoor=NULL, intoutdoor=NULL )
{

  #set some defaults
  if (is.null(man) & is.null(cow) )
  {
    man = 0.8
  }
  if (is.null(indoor)) # & is.null(outdoor) )
  {
    indoor = 0.3
  }
  if (is.null(cow)  )
  {
    cow = 1-man
  }
  # if (is.null(outdoor)  )
  # {
  #   outdoor = 1-indoor
  # }
  if (is.null(man)  )
  {
    man = 1-cow
  }
  # if (is.null(indoor)  )
  # {
  #   indoor = 1-outdoor
  # }

  # **IMPORTANT**
  # indoor sets proportion of man bitten inside
  # therefore outdoor is 1-(man*indoor) not 1-indoor
  outdoor <- 1-(man*indoor)

  #remove blank borders, bltr
  par(mar = c(0,0,1,0),oma = c(0, 0, 0, 0))


  #cat("in pie_feeding man=",man," indoor=",indoor,"\n")


  # subtract the interventions from the total before passing to the pie function
  #radius <- 1-((man*indoor*intervene_indoor) + (cow*intervene_cow))
  # 5/10/16 adding intervene_outdoor
  #radius <- 1-((man*indoor*intervene_indoor) + (cow*intervene_cow) + (man*outdoor*intervene_outdoor))

  feed_man_in <- (indoor*man) - (indoor*man*intervene_indoor)
  feed_man_out <- (outdoor-cow) - ((outdoor-cow)*intervene_outdoor)
  feed_cow <- cow - (cow*intervene_cow)

  feed_proportion <- feed_man_in + feed_man_out + feed_cow
  #to make pies respond by area rather than radius, better for human perception
  radius <- sqrt(feed_proportion) #/pi)

  #to protect against when no exposure, otherwise pie(0) generates error
  pie_plotted <- FALSE
  if (radius > 0)
  {
    #pie(c((1-man)-((1-man)*intervene_cow), man*(1-indoor), (man*indoor)-(man*indoor*intervene_indoor)), col=col, labels=NA, main="", radius=radius, init.angle = 90)
    # 5/10/16 trying to add intervene_outdoor

    pie(c(feed_cow,
          feed_man_out,
          feed_man_in), col=col, labels=NA, main="", radius=radius, init.angle = 90)

    pie_plotted <- TRUE
  }

  #add a circle for if feeding was 100%
  symbols(x=0, y=0, circles=1, inches=FALSE, bty='n', add=pie_plotted)

  #add title text
  #mtext("Vector feeding", line=0)
  mtext(paste("Vector feeding :",round(feed_proportion, digits=2)), line=0)

  # OLD CODE

  #add a check for if indoor>man
  #now that indoor is usd as prop of man this not needed
  # if (indoor > man)
  # {
  #   warning("biting indoor > human implies vectors are biting cattle indoors! exiting plot")
  #   return()
  # }

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
  #invisible(df)

}
