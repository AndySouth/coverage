#' plot feeding
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

plot_feeding <- function( man=NULL, cow=NULL, indoor=NULL, outdoor=NULL,
                          #intervention='bed nets', coverage=0.8,
                          intervene_indoor=0.8, intervene_cow=0,
                          col=c("deepskyblue", "orange", "yellow") )
                          #intman=NULL, intcow=NULL, intindoor=NULL, intoutdoor=NULL )
{

  #set some defaults
  if (is.null(man) & is.null(cow) )
  {
    man = 0.8
  }
  if (is.null(indoor) & is.null(outdoor) )
  {
    indoor = 0.3
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


  # #create dataframe for feeding vis
  # df <- data.frame(
  #   xmin = rep(0,3),
  #   xmax = rep(1,3),
  #   ymin = c(0, cow, outdoor),
  #   ymax = c(cow, outdoor,1),
  #   z = c(1:3)
  # )


  # 6/6/16 i think that human feeding should be multiplied by indoor proportion
  # closer to what suggested in Killen 2014
  df <- data.frame(
    xmin = rep(0,3),
    xmax = rep(1,3),
    ymin = c(0, 1-man, 1-(man*indoor)),
    ymax = c(1-man, 1-(man*indoor),1)
    #z=c(1:3) #determines colours of blocks
  )

  #remove blank borders
  par(mar = c(0,0,0,0),oma = c(0, 0, 0, 0))

  #create blank plot
  #can change extents here to allow in more or less things in borders
  plot(c(-0.2,1.25),c(0,1), type='n', axes=FALSE, xlab='', ylab='', asp=1)

  #add feeding rectangles
  rect(xleft = df$xmin, xright = df$xmax, ybottom = df$ymin, ytop = df$ymax, col=col)


  #add images to label axes

  img_cow <- png::readPNG(system.file("extdata", 'cow_thumb.png', package = "coverage"))
  rasterImage(img_cow, xleft=-0.25, ybottom=cow/2-0.05, xright=-0.15, ytop=cow/2+0.05, interpolate = FALSE)

  img_man <- png::readPNG(system.file("extdata", 'man_thumb.png', package = "coverage"))
  rasterImage(img_man, xleft=-0.25, ybottom=cow + man/2-0.05, xright=-0.15, ytop=cow + man/2+0.05, interpolate = FALSE)

  img_indoor <- png::readPNG(system.file("extdata", 'indoor.png', package = "coverage"))
  rasterImage(img_indoor, xleft=1.1, ybottom=cow + (man*(1-indoor))+(man*indoor)/2-0.1, xright=1.3, ytop=cow+(man*(1-indoor))+(man*indoor)/2+0.1, interpolate = FALSE)

  img_outdoor <- png::readPNG(system.file("extdata", 'outdoor.png', package = "coverage"))
  rasterImage(img_outdoor, xleft=1.1, ybottom=outdoor/2-0.1, xright=1.3, outdoor/2+0.1, interpolate = FALSE)

  # axes after images to overwrite any whitespace
  # tcl=tickmark length, +ve =towards plot
  axis(2, at=c(0, 1-man, 1), labels=FALSE, lwd=3, pos = -0.1, tcl = 1)
  axis(4, at= c(0, 1-(man*indoor), 1), labels=FALSE, lwd=3, pos = 1.1, tcl = 1)


  ################
  ## interventions
  #cat("intervention=",intervention,"\n")


  # #create dataframe for intervention vis - trickier
  # #may need multiple polygons
  # #or should I first just allow bed nets & vet insecticide
  # if (intervention == 'bed nets')
  # {
  #   ymin <- (1-man)+(man*(1-indoor))+((1-coverage)*man*indoor)
  #   ymax <- 1
  # } else if (intervention == 'vet insecticide')
  # {
  #   ymin <- 0
  #   ymax <- (1-man)*coverage
  # }
  #
  # df_int <- data.frame(
  #   xmin = 0,
  #   xmax = 1,
  #   ymin = ymin,
  #   ymax = ymax
  # )
  #
  # #add intervention polygon on top
  # rect(xleft = df_int$xmin, xright = df_int$xmax, ybottom = df_int$ymin, ytop = df_int$ymax, col=rgb(1,1,1,0.95))


  # interventions indoor
  ymin <- (1-man)+(man*(1-indoor))+((1-intervene_indoor)*man*indoor)
  ymax <- 1
  rect(xleft=0, xright=1, ybottom=ymin, ytop=ymax, col=rgb(1,1,1,0.95))

  #interventions cow
  ymin <- 0
  ymax <- (1-man)*intervene_cow
  rect(xleft=0, xright=1, ybottom=ymin, ytop=ymax, col=rgb(1,1,1,0.95))


  #return plot coords in case needed
  invisible(df)

}
