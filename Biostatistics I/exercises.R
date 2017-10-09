setwd("~/School/SDU/Biostatistics I/")

# Exercise 1.1
my.data <- read.table("DataTable.csv", fill = TRUE, header = TRUE, sep = "\t", skip = 1)

# Check if the row and col names were set and if the data are not empty
if (length(rownames(my.data)) > 0 & length(colnames(my.data)) > 0 & length(my.data) > 0) {
  print("Everything was set correctly")
} else {
  print("Something went wrong")
}

# Number of empty values in cols
for (col in colnames(my.data)) {
  n <- sum(is.na(my.data[col]))
  print(sprintf("[%s] -> %d", col, n))
}
colSums(is.na(my.data)) # other way

# Number of empty values in rows
for (row in 1:nrow(my.data)) {
  m <- sum(is.na(my.data[row,]))
  print(sprintf("[%d] -> %d", row, m))
}
rowSums(is.na(my.data)) # other way

# Exercise 1.2
install.packages("MASS")
library(MASS)
data("Pima.tr2")
dim(Pima.tr2)

# Number of empty values in cols
for (col in colnames(Pima.tr2)) {
  n <- sum(is.na(Pima.tr2[col]))
  print(sprintf("[%s] -> %d", col, n))
}

# Number of empty values in rows
for (row in 1:nrow(Pima.tr2)) {
  m <- sum(is.na(Pima.tr2[row,]))
  print(sprintf("[%d] -> %d", row, m))
}

# table example
table(colSums(is.na(Pima.tr2)))
table(rowSums(is.na(Pima.tr2)))

# Exercise 1.3
# Exercise 1.3.1
mean(1:21)
range(1:21)

# Exercise 1.3.2
mean(rnorm(50, 0, sd = 1))
range(rnorm(50, 0, sd = 1))

mean(women$height)
range(women$height)

# Exercise 1.4
median(1:21)
sum(1:21)
sd(1:21)

# Exercise 1.5
library(MASS)
data("mammals")
plot(mammals$body~mammals$brain)
plot(mammals$body, mammals$brain)
plot(mammals$brain, mammals$body)
plot(log(mammals$body), log(mammals$brain))
plot(log="xy", mammals$body, mammals$brain)

# Exercise 1.6
# See pictures/exercise-1.6
# xlim, ylim
plot(trees)
plot(range(trees$Girth), c(min(range(trees$Height), range(trees$Volume)), max(range(trees$Height), range(trees$Volume))), xlab = "Gifrth", ylab = "Range", type = "n")
lines(trees$Girth, trees$Height, col = "red")
lines(trees$Girth, trees$Volume, col = "green")
legend("bottomright", legend=c("Girth to Height", "Girth to Volume"), col=c("red", "green"), lty = 1)

# Exercise 1.7
# example woth order
a <- order(trees$Height)
trees1 <- trees[a,]
trees1

genotype[order(genotype$Wt), ]
genotype[order(genotype$Mother), ]
genotype[order(genotype$Mother, genotype$Wt), ]

# Exercise 1.8
# Exercise 1.8.1
for (i in (1:10)) {
  print(i)
}

# Exercise 1.8.2
i = 1
while(i <= 10) {
  print(i)
  i = i + 1
}

# Exercise 1.8.3
print((1:10))

# Exercise 1.9
# sep => separates
# collapse => puts together (concat)
a <- c("Leo", "the", "lion")
paste(a, sep="_")
paste(a, collapse="#")

# Exercise 1.10
MeanAndSd <- function (x) {
  av <- mean(x)
  sdev <- sd(x)
  c(mean=av, sd=sdev)
}

###############################################################

# Exercise 2.1
class("a")
library(MASS)
data("cabbages")
cabbages
sapply(cabbages, class)
dt3 <- data.frame(cabbages$HeadWt, cabbages$VitC)

# Exercise 2.2
# Notes: sapply summarizes compared to just apply
class(dt3)
dim(dt3)
rownames(dt3)
str(dt3)
dt4 <- data.frame(DNase, cabbages)

table(DNase)
sapply(DNase, table)
sapply(DNase$conc, mean)
sapply(DNase$Run, class)

# Exercise 2.3
plot(rnorm(c(100)))
plot(rnorm(sample(100)))

# dev.off()
par(mfrow=c(2,2))

# Notes: the more the better
y <- rnorm(100)
hist(y, probability=TRUE)
lines(density(y))

y <- rnorm(25)
hist(y, probability=TRUE)
lines(density(y))

y <- rnorm(500)
hist(y, probability=TRUE)
lines(density(y))

# Exercise 2.4
# Notes: replace uses the same number multiple time
sample(c(1:5))
sample(c(1:5), replace = T)

# Exercise 2.5
# Notes: similar to SQL: GROUP BY, but more advanced
data("Pima.tr2")
count.na <- function(x) sum(is.na(x))
colSums(is.na(Pima.tr2)) # other way
by(Pima.tr2, Pima.tr2$type, function(x) sapply(x, count.na))

# Exercise 2.5.2
Pima.tr2
anymiss <- complete.cases(Pima.tr2)
cbind(Pima.tr2, anymiss)

# Exercise 2.6
# The more values the better the results (should work like this)
a <- rnorm(100, mean=0, sd=1)
b <- rnorm(200, mean=0, sd=1)
plot(density(a))
lines(density(b), col=2)
qqplot(a,b)
abline(0,1)

# Exercise 2.7
# TODO
# dev.off()
data("mammals")
mam.lm <- lm(log10(brain) ~ log10(body), data=mammals)
abline(mam.lm)
coef(mam.lm)

# Exercise 2.8
# TO DO

# Exercise 2.9
# TO DO

###############################################################

# Exercise 3
# Exercise 3.1.1
x <- seq(0, 5, 0.01)
plot(x, dnorm(x, mean = 2.5, sd = 1.5), type = "l")
plot(x, pnorm(x, mean = 2.5, sd = 1.5), type = "l")

# Exercise 3.1.2
pnorm(4, 2.5, 1.5) - pnorm(0.5, 2.5, 1.5)

# Exercise 3.1.3
dnorm(x=2, 2.5, 1.5)

# Exercise 3.2
x <- seq(-5, 5, 0.01)
plot(x, dt(x, df = 3))
lines(x, dnorm(x), type = "l")

plot(x, pt(x, df = 3))
lines(x, dnorm(x), type = "l")

# Exercise 3.3
x <- seq(0, 25, 1)
y <- rnorm(x, mean = 0, sd = 1.0)
hist(y, probability = TRUE)

# Exercise 3.3 a)
lines(density(y), col = "red")

# Exercise 3.3 b) 
x <- seq(-2, 2, 0.01)
lines(dnorm(x)~x, col = "blue")

# Exercise 3.4.1
library("MASS")
x <- seq(-10, 10, 1)
hist(log(Animals$body), probability = T)
lines(density(log(Animals$body)), col = "red")

# Exercise 3.4.2
lines(x, dnorm(x, sd = sd(log(Animals$body)), mean = mean(log(Animals$body))), col = "blue")

# Exercise 3.5
plot(density(rnorm(50)), type="l")


# Exercise 3.6
plot(density(rnorm(50), bw=0.15), type="l")
plot(density(rnorm(50), bw=0.2), type="l")
plot(density(rnorm(50), bw=0.6), type="l")
plot(density(rnorm(50), bw=0.75), type="l")

# Exercise 3.7


# Exercise 3.13
y1 <- rnorm(51)
y <- y1[-1] + y1[-51]
par(mfrow=c(1,2))
y1
y
acf(y1)
acf(y)

# Exercise 3.14

# Exercise 4.1

