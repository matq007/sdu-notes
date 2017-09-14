setwd("~/School/SDU/Biostatistics I/")

data("iris")

library(Biobase)
data("geneData")

x <- seq(0, 1, 0.1)
y <- exp(x)
plot(x, y)

mydf <- data.frame(x = x, y = y, sin = sin(x), tan = tan(x))
names(mydf)
plot(mydf$x, mydf$y)
plot(y ~ x, mydf)

plot(tan, xlim = c(0, 10))

pow <- function(x) {
  x ^ 4.1
}

plot(pow, xlim=c(0.01, 1000), log = "xy")

plot(x, pow(x), xlim = c(0.01, 1), log = "xy", type = "p", pch = 1, cex = 1, col = 10)
plot(circle)
plot(0, 0, cex = 10)

cmeans <- colMeans(log2(geneData), na.rm = T)
cmeans

barplot(cmeans)
bar <- barplot(cmeans, ylim=c(0,10))
bar

lines(bar, cmeans)
arrows(bar, cmeans, bar, cmeans+2, length = 0.1, angle = 90)

par(lwd = 5)
plot(cos)

dev.off() # quick destroy function

par(mar = c(1,1,1,1))
pairs(geneData[, 1:5])

hist(log(geneData[,1], 100))
rand.dat <- cbind(rnorm(200), rnorm(200), rnorm(200))
pairs(rand.dat)
persp(rand.dat, theta = 40)
heatmap(rand.dat)

heatmap(na.omit(log(geneData)))
