#' plot feeding
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
#' plot_feeding(man=0.5, indoor=0.7, intervene_indoor=0.5)
#'
#' @return dataframe of some plot coords
#' @export

plot_feeding <- function( man=NULL, cow=NULL, indoor=NULL,
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
    ymin = c(0, 1-man, outdoor),
    ymax = c(1-man, outdoor,1)
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
  ybottom <- cow/2-0.05
  rasterImage(img_cow, xleft=-0.25, ybottom=ybottom, xright=-0.15, ytop=cow/2+0.05, interpolate = FALSE)
  text(-0.25+0.01, adj=0, ybottom-0.05, "cattle")

  img_man <- png::readPNG(system.file("extdata", 'man_thumb.png', package = "coverage"))
  ybottom <- cow + man/2-0.05
  rasterImage(img_man, xleft=-0.25, ybottom=ybottom, xright=-0.15, ytop=cow + man/2+0.05, interpolate = FALSE)
  text(-0.25+0.01, adj=0, ybottom-0.05, "humans")

  img_indoor <- png::readPNG(system.file("extdata", 'indoor.png', package = "coverage"))
  ybottom <- cow + (man*(1-indoor))+(man*indoor)/2-0.1
  rasterImage(img_indoor, xleft=1.1, ybottom=ybottom, xright=1.3, ytop=cow+(man*(1-indoor))+(man*indoor)/2+0.1, interpolate = FALSE)
  text(1.1+0.1, ybottom, "indoors")


  img_outdoor <- png::readPNG(system.file("extdata", 'outdoor.png', package = "coverage"))
  ybottom <- outdoor/2-0.1
  rasterImage(img_outdoor, xleft=1.1, ybottom=ybottom, xright=1.3, outdoor/2+0.1, interpolate = FALSE)
  text(1.1+0.1, ybottom, "outdoors")

  # axes after images to overwrite any whitespace
  # tcl=tickmark length, +ve =towards plot
  # left
  axis(2, at=c(0, 1-man, 1), labels=FALSE, lwd=3, pos = -0.1, tcl = 1)
  # right
  axis(4, at= c(0, outdoor, 1), labels=FALSE, lwd=3, pos = 1.1, tcl = 1)


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
  #ymin <- (1-man)+(man*(1-indoor))+((1-intervene_indoor)*man*indoor)
  ymin <- 1-(indoor * man * intervene_indoor)
  ymax <- 1
  rect(xleft=0, xright=1, ybottom=ymin, ytop=ymax, col=rgb(1,1,1,0.95))

  #interventions cow
  ymin <- 0
  ymax <- (1-man)*intervene_cow
  rect(xleft=0, xright=1, ybottom=ymin, ytop=ymax, col=rgb(1,1,1,0.95))

  # 5/10/16 trying to add intervene_outdoor for insecticide emanators as requested by Gerry
  ymin <- outdoor-(intervene_outdoor*(outdoor-cow))
  ymax <- outdoor
  rect(xleft=0, xright=1, ybottom=ymin, ytop=ymax, col=rgb(1,1,1,0.95))


  #return plot coords in case needed
  invisible(df)

}
