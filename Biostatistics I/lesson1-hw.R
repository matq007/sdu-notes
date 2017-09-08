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

# TODO: table()

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
genotype
sort(genotype)
genotype$Wt[order(genotype$Wt)]
