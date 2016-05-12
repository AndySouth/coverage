#' plot feeding
#'
#' plots vector feeding based on behaviour inputs
#'
#' @param man
#' @param cow
#' @param indoor
#' @param outdoor
#'
#' @return dataframe of some plot coords
#' @export

plot_feeding <- function( man=NULL, cow=NULL, indoor=NULL, outdoor=NULL ){


  #set some defaults
  if (is.null(man) & is.null(cow) & is.null(indoor) & is.null(outdoor) )
  {
    man = 0.8
    cow = 0.2
    indoor = 0.3
    outdoor = 0.7
  }

  # dataframe not needed
  # dfv <- data.frame(
    # man = 0.8,
    # cow = 0.2,
    # indoor = 0.3,
    # outdoor = 0.7
  # )


  df <- data.frame(
    xmin = rep(0,3),
    xmax = rep(1,3),
    ymin = c(0, cow, outdoor),
    ymax = c(cow, outdoor,1), z=c(1:3)
  )


  #remove blank borders
  par(mar = c(0,0,0,0),oma = c(0, 0, 0, 0))

  #create blank plopt
  plot(c(-0.2,1.3),c(0,1), type='n', axes=FALSE, xlab='', ylab='')

  #add rectangles
  rect(xleft = df$xmin, xright = df$xmax, ybottom = df$ymin, ytop = df$ymax, col=df$z)


  #add images to label axes

  img_cow <- readPNG(system.file("extdata", 'cow_thumb.png', package = "coverage"))
  rasterImage(img_cow, xleft=-0.25, ybottom=cow/2-0.05, xright=-0.15, ytop=cow/2+0.05, interpolate = FALSE)

  img_man <- readPNG(system.file("extdata", 'man_thumb.png', package = "coverage"))
  rasterImage(img_man, xleft=-0.25, ybottom=cow + man/2-0.05, xright=-0.15, cow + man/2+0.05, interpolate = FALSE)

  img_indoor <- readPNG(system.file("extdata", 'indoor.png', package = "coverage"))
  rasterImage(img_in, xleft=1.1, ybottom=outdoor+indoor/2-0.1, xright=1.3, outdoor+indoor/2+0.1, interpolate = FALSE)

  img_outdoor <- readPNG(system.file("extdata", 'outdoor.png', package = "coverage"))
  rasterImage(img_out, xleft=1.1, ybottom=outdoor/2-0.1, xright=1.3, outdoor/2+0.1, interpolate = FALSE)

  #axes after images to overwrite any whitespace
  axis(2, at=c(0, cow, 1), labels=FALSE, lwd=3, pos = -0.1)
  axis(4, at= c(0, outdoor, 1), labels=FALSE, lwd=3, pos = 1.1)

  #return plot coords in case needed
  invisible(df)

}
