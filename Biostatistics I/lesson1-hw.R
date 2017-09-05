setwd("~/School/SDU/Biostatistics I/")

# Exercise 1.1
my.data <- read.table("DataTable.csv", fill = TRUE, header = TRUE, sep = "\t", row.names = 1)

# Exercise 1.2
# install.packages("MASS")
# library("MASS")

# data("Pima.tr2")
# dim(my.data)
# table()

# n <- count.fields("DataTable.csv", blank.lines.skip = FALSE)
# x <- readLines("DataTable.csv");
# head(x[n] == 29)

# my.data[2]

# n <- count.fields("DataTable.csv", sep = "\n", blank.lines.skip = FALSE)
# sum(is.na(my.data[14]))

# EXERCISE 1
sum(is.na(my.data))

library("MASS")
sum(is.na(Pima.tr2))

colSums(is.na(Pima.tr2))
rowSums(is.na(Pima.tr2))

table(Pima.tr2$npreg)
table(rowSums(is.na(Pima.tr2)))

# colnames(my.data)

# for (i in colnames(my.data)) {
  #m <- sum(is.na(my.data[i]))
  #print(cat(sprintf("[%s] -> [%d]", i, m)))
#}


# Normal distribution
rnorm(50)
mean(rnorm(10000000))
