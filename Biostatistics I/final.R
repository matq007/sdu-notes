library(MASS)
Animals

install.packages("plotly")

library(ggplot2)
library(plotly)
install.packages("data.table")

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(p)



x <- seq(-5, 5, 0.01)
t <- dnorm(x, sd = 0.2)
plot(x, t, type = "l")
dnorm(0)
summary(t)
sd(t)
mean(t)
var(t)

## Hypothesis 
# null hypothesis: constant standard deviation sd=1 and mean=0
# 0.05 (5%) threshold, alternative hypothesis: mean of values is larger than 0
# sum of normally distributed random numbers is normal distribution 
# with same mean and s.d. s/sqrt(n)
n <- 10
m <- 1
sd <- 1.5/sqrt(n)
# quantile 0.95 of distribution
m + sd * qnorm(0.95)
# i.e., for a means of 10 values larger 1.78, one can reject the null hypothesis

## Regression
x <- runif(100)
y <- 2 * x + 3 + rnorm(100)
lm.out <- lm(y~x)
summary(lm.out)
plot(x, y)
abline(lm.out, col=2, lwd=2)


data(LakeHuron)
LakeHuron
test.data <- data.frame(x=1875:1972,y=as.vector(LakeHuron))
test.data
plot(test.data)
plot(y ~ x, test.data)

lm.out <- lm(y ~ x, test.data)
summary(lm.out)
plot(y ~ x, test.data)
lines(test.data$x, lm.out$fitted.values, lwd=2, col=2)
abline(lm.out)

lm.out <- lm(log(y-575) ~ x, test.data)
lm.out
plot(y ~ x, test.data)
lines(test.data$x, exp(lm.out$fitted.values)+575, lwd=2, col=2)

lm.out <- lm(y ~ poly(x,2), test.data)
summary(lm.out)
plot(y ~ x, test.data)
lines(test.data$x, lm.out$fitted.values, lwd=2, col=2)


plot(residuals(lm.out))
abline(0, 0)
hist(residuals(lm.out))
qqnorm(residuals(lm.out))



## the lm function
data(airquality)
# remove missing values (not required)
airquality <- airquality[rowSums(is.na(airquality))==0,]
airquality
names(airquality)
plot(airquality)
lm.out <- lm(Ozone ~ Solar.R + Wind + Temp + Day, airquality)
summary(lm.out)
plot(Ozone ~ Wind, airquality)
points(airquality$Wind, lm.out$fitted.values,col=2, pch=15)
plot(Ozone ~ Temp, airquality)
points(airquality$Temp, lm.out$fitted.values,col=2, pch=15)
plot(Ozone ~ Day, airquality)
points(airquality$Day, lm.out$fitted.values, col=2, pch=15)
plot(Ozone ~ Solar.R, airquality)
plot(Ozone ~ Solar.R, airquality, cex=Wind/10, pch=15)
plot(Ozone ~ Solar.R, airquality, cex=Wind/10, pch=15, col=rainbow(100)[Temp])
plot(residuals(lm.out))
abline(0,0)


class(lm.out)
names(lm.out)
coef(lm.out)
residuals(lm.out)
vcov(lm.out)

lm.out2 <- lm(Ozone ~ Solar.R + Wind * Temp + Day, airquality)
lm.out3 <- lm(Ozone ~ Solar.R * Wind + Temp + Day, airquality)
lm.out4 <- lm(Ozone ~ Solar.R + Wind + Temp * Day, airquality)
lm.out5 <- lm(Ozone ~ Solar.R * Wind + Temp, airquality)
lm.out6 <- lm(Ozone ~ Solar.R + Wind, airquality)


library(MASS)
data(mammals)
plot(mammals)
plot(mammals, log="xy")

y <- mammals$brain
x <- mammals$body
lm.out <- lm(y~poly(x,2))
summary(lm.out)
plot(residuals(lm.out))
qqnorm(residuals(lm.out))


plot(residuals(lm.out))
qqnorm(residuals(lm.out))


x <- log(mammals$body)
lm.out <- lm(log(y)~x)
summary(lm.out)
plot(residuals(lm.out))
qqnorm(residuals(lm.out))


hist(rpois(10000,5), 100)

failure.df <- rbind(
  c(  33.3,  25.3,  15),
  c(  52.2,  14.4,  9),
  c(  64.7,  32.5,  14),
  c( 137.0,  20.5,  24),
  c( 125.9,  97.6,  27),
  c( 116.3,  53.6,  27),
  c( 131.7,  56.6,  23),
  c( 85.0, 87.3, 18),
  c( 91.9,  47.8,   22))
failure.df <- as.data.frame(failure.df)
colnames(failure.df) <- c("Mode1","Mode2","Failures")
failure.df

plot(Failures ~ Mode1, failure.df)
plot(Failures ~ Mode2, failure.df)


glm.out <- glm(Failures~Mode1+Mode2, failure.df, family=poisson)
summary(glm.out)
plot(glm.out)

pred.data <- data.frame(Mode1=1:200, Mode2=1:200)
pred <- predict(glm.out, pred.data, type="response")
plot(Failures ~ Mode1, data=failure.df, xlim=c(1,200))
lines(1:200, pred)
plot(Failures ~ Mode2, data=failure.df, xlim=c(1,200))
lines(1:200, pred)



norm.dat <- rnorm(100)
lm.out <- lm(norm.dat~1)
summary(lm.out)

# p=c(mean, sd)
loglikelihood <- function (p) {
  n <- length(norm.dat)
  m <- p[1]
  s <- p[2]
  n/2*log(2*pi) + n*log(s) + sum((norm.dat-m)^2) / (2*s^2)
}
loglikelihood(c(0,1))
loglikelihood(c(0.5, 1))

nlm.out <- nlm(loglikelihood, c(1,0.1) )
nlm.out
nlm.out$estimate
nlm.out <- nlm(loglikelihood, c(0,1) )
nlm.out$estimate
loglikelihood(nlm.out$estimate)
hist(norm.dat, freq=F,50)
lines(seq(-5,5,0.01),dnorm(seq(-5,5,0.01),mean=nlm.out$estimate[1],sd=nlm.out$estimate[2]))
lines(seq(-5,5,0.01),dnorm(seq(-5,5,0.01),0,1), col=2, lwd=2)


data(women)
fit = lm(weight ~ height, women) # Run a regression analysis
par(mfrow=c(2,2))
plot(fit)


plot(seq(-4, 4, 0.01), dt(seq(-4, 4, 0.01), df = 2))
plot(seq(-4, 4, 0.01), dt(seq(-4, 4, 0.01), df = 3))
plot(seq(-4, 4, 0.01), dt(seq(-4, 4, 0.01), df = 10))
plot(seq(-4, 4, 0.01), dt(seq(-4, 4, 0.01), df = 30))


library(lattice)
# now we do a full t-test
# Problem: is gene differently expressed in control and disease?
gene.values <- c(-0.156779906618839, -1.19258492462641, -0.584097898869027, 
                 -1.05973269590046, 0.241034604602436, 0.622092984491641, 0.429889283129897, 
                 1.21134263252275)
my.dat <- data.frame(genes=gene.values, condition=rep(c("A","B"), each=4))
my.dat
sapply(my.dat, class)
plot(genes~condition, my.dat)
stripplot(genes~condition, my.dat)

means <- by(my.dat$genes, my.dat$condition, mean)
sds <- by(my.dat$genes, my.dat$condition, sd)
sds
# standard deviations are similar -> GOOD!
msd <- mean(sds)



A <- data.frame(y=rnorm(100), 
                x=c(rep("A",50),rep("B",50)))

t.out <- t.test(A[A[,2]=="A",1], A[A[,2]=="B",1])
t.out

lm.out <- lm(y~x, A)
summary(lm.out)
plot(A$x, residuals(lm.out))
qqnorm(residuals(lm.out))

A <- data.frame(y=c(rnorm(50),rnorm(50)+1), 
                x=c(rep("A",50),rep("B",50)))
plot(y~x, A)
t.out <- t.test(A[A[,2]=="A",1], A[A[,2]=="B",1])
t.out

A <- data.frame(y=rnorm(150), 
                x=c(rep("A",50),rep("B",50),rep("C",50)))
stripplot(y~x, data=A, ylab="Measurements", xlab="")
plot(y~x,A)
lm.out <- lm(y~x, A)
summary(lm.out)
plot(A$x, residuals(lm.out))
plot(lm.out$fitted.values, lm.out$residuals)
qqnorm(residuals(lm.out))