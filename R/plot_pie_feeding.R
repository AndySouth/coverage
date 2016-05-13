#' plot pie of feeding
#'
#' plots vector feeding based on behaviour inputs
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

plot_pie_feeding <- function( man=NULL, cow=NULL, indoor=NULL, outdoor=NULL,
                          intervention='bed nets', coverage=0.8 )
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


  #create dataframe for feeding vis
  df <- data.frame(
    xmin = rep(0,3),
    xmax = rep(1,3),
    ymin = c(0, cow, outdoor),
    ymax = c(cow, outdoor,1),
    z = c(1:3)
  )


  #remove blank borders, bltr
  par(mar = c(0,0,1,0),oma = c(0, 0, 0, 0))

  #plot pie
  pie(c(cow, man-indoor, indoor), col=df$z, labels=NA, main="Vector feeding", radius=1)


  #create dataframe for intervention vis - trickier
  #may need multiple polygons
  #or should I first just allow bed nets & vet insecticide
  if (intervention == 'bed nets')
  {
    ymin <- outdoor+((1-coverage)*indoor)
    ymax <- 1
  } else if (intervention == 'vet insecticide')
  {
    ymin <- 0
    ymax <- cow*coverage
  }

  df_int <- data.frame(
    xmin = 0,
    xmax = 1,
    ymin = ymin,
    ymax = ymax
  )

  #add intervention polygon on top
  #to do I could also add to the side ?
  #rect(xleft = df_int$xmin, xright = df_int$xmax, ybottom = df_int$ymin, ytop = df_int$ymax, col="white")



  #return plot coords in case needed
  invisible(df)

}
