#coverage_starting.r

#andy south 11/5/2016

#first go at creating some coverage visualisations

#git remote add origin git@github.com:AndySouth/coverage.git
#but because i set to wrong one first
#git remote set-url origin git@github.com:AndySouth/coverage.git
#git pull origin master
#git push -u origin master



dfv <- data.frame(
  man = 0.7,
  cow = 0.3,
  indoor = 0.6,
  outdoor = 0.4
)

dfv <- data.frame(
  man = 0.8,
  cow = 0.2,
  indoor = 0.3,
  outdoor = 0.7
)


df <- data.frame(
  xmin = rep(0,3),
  xmax = rep(1,3),
  ymin = c(0, dfv$cow, dfv$outdoor),
  ymax = c(dfv$cow, dfv$outdoor,1), z=c(1:3)
)

rect(xleft = df$xmin, xright = df$xmax, ybottom = df$ymin, ytop = df$ymax, col=df$z)
plot(c(-0.2,1.3),c(0,1), type='n', axes=FALSE, xlab='', ylab='')
rect(xleft = df$xmin, xright = df$xmax, ybottom = df$ymin, ytop = df$ymax, col=df$z)


#starting to think about adding images
#image <- as.raster(matrix(0:1, ncol = 5, nrow = 3))
#rasterImage(image, xleft=0.1, ybottom=0.1, xright=0.2, ytop=0.2, interpolate = FALSE)

library(png) #for readPNG
img_cow <- readPNG('cow_thumb.png')
rasterImage(img_cow, xleft=-0.25, ybottom=dfv$cow/2-0.05, xright=-0.15, ytop=dfv$cow/2+0.05, interpolate = FALSE)

img_man <- readPNG('man_thumb.png')
rasterImage(img_man, xleft=-0.25, ybottom=dfv$cow + dfv$man/2-0.05, xright=-0.15, dfv$cow + dfv$man/2+0.05, interpolate = FALSE)

img_in <- readPNG('indoor.png')
rasterImage(img_in, xleft=1.1, ybottom=dfv$outdoor+dfv$indoor/2-0.1, xright=1.3, dfv$outdoor+dfv$indoor/2+0.1, interpolate = FALSE)

img_out <- readPNG('outdoor.png')
rasterImage(img_out, xleft=1.1, ybottom=dfv$outdoor/2-0.1, xright=1.3, dfv$outdoor/2+0.1, interpolate = FALSE)

#axes after images to overwrite any whitespace
axis(2, at=c(0, dfv$cow, 1), labels=FALSE, lwd=3, pos = -0.1)
axis(4, at= c(0, dfv$outdoor, 1), labels=FALSE, lwd=3, pos = 1.1)


