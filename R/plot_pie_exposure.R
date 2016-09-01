#' plot pie of human exposure
#'
#' plots human exposure based on behaviour inputs
#'
#' @param man
#' @param cow
#' @param indoor
#' @param outdoor
#' @param intervention one of 'bed nets', 'vet insecticide'
#' @param coverage target coverage of the chosen intervention (i.e. what proportion of it's target does it get)
#'
#' @return dataframe of some plot coords
#' @export

plot_pie_exposure <- function( man=NULL, cow=NULL, indoor=NULL, outdoor=NULL,
                          intervention='bed nets', coverage=0.8,
                          col=c("deepskyblue", "orange", "yellow"))
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
  if (man-indoor==0 & indoor-(indoor*coverage)==0)
  {
    warning("no human exposure, exiting plot")
    return()
  }



  #create dataframe for feeding vis
  df <- data.frame(
    xmin = rep(0,3),
    xmax = rep(1,3),
    ymin = c(0, cow, outdoor),
    ymax = c(cow, outdoor,1),
    #z = c(1:3)
    #z = c("yellow", "orange", "deepskyblue"),
    stringsAsFactors = FALSE
  )


  #remove blank borders, bltr
  par(mar = c(0,0,1,0),oma = c(0, 0, 0, 0))


  #including intervention
  if (intervention == 'bed nets')
  {
    #add intervention to end (man indoors)
    #pie(c(man-indoor, indoor-(indoor*coverage)), col=c(df$z[2:3]), labels=NA, main="", radius=1)
    #6/6/16 change now that indoor is a proportion of man
    #pie(c(man-(man*indoor), man*indoor*(1-coverage) ), col=c(df$z[2:3]), labels=NA, main="", radius=1)
    #8/6/16 set radius from proportion of max humans exposed
    pie(c(man-(man*indoor), man*indoor*(1-coverage) ), col=col[2:3], labels=NA, main="", radius=man-(man*indoor*coverage), init.angle = 90)

  } else if (intervention == 'vet insecticide')
  {
    #add intervention to start (cow)
    #pie(c(man-indoor, indoor), col=c(df$z[2:3]), labels=NA, main="", radius=1)
    #6/6/16 change now that indoor is a proportion of man
    #pie(c(man-(man*indoor), man*indoor ), col=c(df$z[2:3]), labels=NA, main="", radius=1)
    #8/6/16 set radius from proportion of max humans exposed
    pie(c(man-(man*indoor), man*indoor ), col=col[2:3], labels=NA, main="", radius=man, init.angle = 90)

  }

  #add a circle for if exposure was 100%
  symbols(x=0, y=0, circles=1, inches=FALSE, add=TRUE)

  #add title text
  mtext("Human exposure", line=0)


  #return plot coords in case needed
  invisible(df)

}
