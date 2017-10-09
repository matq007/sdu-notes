data("LakeHuron")
LakeHuron
test.data <- data.frame(x = 1875:1972, y = as.vector(LakeHuron))
test.data
plot(y ~ x, test.data)

lm.out <- lm(y ~ x, test.data)

summary(lm.out)
lines(test.data$x, lm.out$fitted.values, lwd = 2, col = 2)
abline(lm.out)


lm.out <- lm(log(y - 575) ~ x, test.data)
summary(lm.out)
plot(y ~ x, test.data)
lines(test.data$x, exp(lm.out$fitted.values) + 575, lwd = 2, col = 2)

lm.out <- lm(y ~ poly(x, 2), test.data)
summary(lm.out)
lines(test.data$x, lm.out$fitted.values, lw = 2, col = 2)


plot(residuals(lm.out))
pairs(airquality)
airquality <- airquality[rowSums(is.na(airquality)) == 0,]
plot(airquality)

lm.out1 <- lm(Ozone ~ Solar.R + Wind + Temp + Day, airquality)
summary(lm.out)
lm.out2 <- lm(Ozone ~ Solar.R + Wind + Temp, airquality)
anova(lm.out1, lm.out2)

x <- seq(-4, 4, 0.1)
plot(x, dnorm(x), type = "l")

