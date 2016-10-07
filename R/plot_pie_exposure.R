#' plot pie of human exposure
#'
#' plots human exposure based on behaviour inputs
#'
#' @param man
#' @param cow
#' @param indoor
# @param outdoor
#' @param intervene_indoor proportion coverage of intervention targetting indoor
#' @param intervene_cow proportion coverage of intervention targetting livestock
#' @param intervene_outdoor proportion coverage of intervention targetting outdoor
# @param intervention one of 'bed nets', 'vet insecticide'
# @param coverage target coverage of the chosen intervention (i.e. what proportion of it's target does it get)
#'
#' @examples
#' plot_pie_exposure(man=0.5, indoor=0.7, intervene_indoor=0.5)
#'
#' @return nothing
#' @export

plot_pie_exposure <- function( man=NULL, cow=NULL, indoor=NULL,
                               #outdoor=NULL,
                               #intervention='bed nets', coverage=0.8,
                               intervene_indoor=0, intervene_cow=0,
                               intervene_outdoor=0,
                               col=c("deepskyblue", "orange", "yellow"))
  #intman=NULL, intcow=NULL, intindoor=NULL, intoutdoor=NULL )
{

  #set some defaults
  if (is.null(man) & is.null(cow) )
  {
    man = 0.8
  }
  if (is.null(indoor))# & is.null(outdoor) )
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

  #radius of the pie reduced due to interventions
  #intervene_cow doesn't effect human exposure
  #todo check whether I should do something to make area respond rather than radius
  #radius <- man-(man*indoor*intervene_indoor)
  # 5/10/16 adding intervene_outdoor
  # same calculations as feed* in plot_pie_feeding()
  expose_man_in <- (indoor*man) - (indoor*man*intervene_indoor)
  expose_man_out <- (outdoor-cow) - ((outdoor-cow)*intervene_outdoor)

  #radius <- man-(man*indoor*intervene_indoor*intervene_outdoor)
  expose_proportion <- expose_man_in + expose_man_out

  #to make pies respond by area rather than radius, better for human perception
  radius <- sqrt(expose_proportion) #/pi)

  #to protect against when no exposure, otherwise pie(0) generates error
  pie_plotted <- FALSE
  if (radius > 0)
  {
    #pie(c(man-(man*indoor), man*indoor*(1-intervene_indoor) ), col=col[2:3], labels=NA, main="", radius=radius, init.angle = 90)
    pie(c(expose_man_out, expose_man_in ), col=col[2:3], labels=NA, main="", radius=radius, init.angle = 90)

    pie_plotted <- TRUE
  }

  #add a circle for if feeding was 100%
  symbols(x=0, y=0, circles=1, inches=FALSE, bty='n', add=pie_plotted)


  #add title text
  mtext(paste("Human exposure :",round(expose_proportion, digits=2)), line=0)


  # OLD CODE

  #add a check for if indoor>man
  #now that indoor is usd as prop of man this not needed
  # if (indoor > man)
  # {
  #   warning("biting indoor > human implies vectors are biting cattle indoors! exiting plot")
  #   return()
  # }
  # todo check how best to deal with zero human exposure
  # if (man-indoor==0 & indoor-(indoor*coverage)==0)
  # {
  #   warning("no human exposure, exiting plot")
  #   return()
  # }


  # #create dataframe for feeding vis
  # df <- data.frame(
  #   xmin = rep(0,3),
  #   xmax = rep(1,3),
  #   ymin = c(0, cow, outdoor),
  #   ymax = c(cow, outdoor,1),
  #   #z = c(1:3)
  #   #z = c("yellow", "orange", "deepskyblue"),
  #   stringsAsFactors = FALSE
  # )

  # #including intervention
  # if (intervention == 'bed nets')
  # {
  #   #add intervention to end (man indoors)
  #   #pie(c(man-indoor, indoor-(indoor*coverage)), col=c(df$z[2:3]), labels=NA, main="", radius=1)
  #   #6/6/16 change now that indoor is a proportion of man
  #   #pie(c(man-(man*indoor), man*indoor*(1-coverage) ), col=c(df$z[2:3]), labels=NA, main="", radius=1)
  #   #8/6/16 set radius from proportion of max humans exposed
  #   pie(c(man-(man*indoor), man*indoor*(1-coverage) ), col=col[2:3], labels=NA, main="", radius=man-(man*indoor*coverage), init.angle = 90)
  #
  # } else if (intervention == 'vet insecticide')
  # {
  #   #add intervention to start (cow)
  #   #pie(c(man-indoor, indoor), col=c(df$z[2:3]), labels=NA, main="", radius=1)
  #   #6/6/16 change now that indoor is a proportion of man
  #   #pie(c(man-(man*indoor), man*indoor ), col=c(df$z[2:3]), labels=NA, main="", radius=1)
  #   #8/6/16 set radius from proportion of max humans exposed
  #   pie(c(man-(man*indoor), man*indoor ), col=col[2:3], labels=NA, main="", radius=man, init.angle = 90)
  # }

  #return plot coords in case needed
  #invisible(df)

}
