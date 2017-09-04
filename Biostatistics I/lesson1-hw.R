setwd("~/School/SDU/Biostatistics I/")

# Exercise 1.1
my.data <- read.table("DataTable.csv", fill = TRUE, header = TRUE)

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

n <- count.fields("DataTable.csv", sep = "\n", blank.lines.skip = FALSE)

