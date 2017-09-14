setwd("~/School/SDU/Biostatistics I/")

# Installation
# source("https://bioconductor.org/biocLite.R")
# biocLite("Biobase")
library(Biobase)

data(geneData)
head(geneData)
boxplot(log(geneData))

seq(0, -1, length.out = 10)
rep(1:10, each = 2)
paste(0:(-10), rep(LETTERS[6:10], each = 2), rep(letters[1:2], 5), sep = "")

x<- seq(0, 10, 0.01)
plot(x, cos(x))

hist(rnorm(1000))
seq(10, -0.2, by = -0.2)

1:20 %in% c(2,3)
