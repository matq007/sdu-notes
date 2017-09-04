# Set working directory or through session
# setwd("") 

# Show all the data with the header
# my.data <- read.table("ExampleFile.csv", sep = ",", fill = TRUE)

# Show data without the header
my.data <- read.table("ExampleFile.csv", sep = ",", fill = TRUE, header = TRUE, comment.char = "")

# Display first 6 lines
head(my.data)

# Easy read
# my.data <- read.table("ExampleFile.csv")

# Operators

# 9 / 2 = 4.5 
# 9 %% 2 = 1
# 9 %/% 2 = 4 
# %% modulo

# c, seq(), rep(), sample(), mean(), sum(), median(), sd()
# help -> ?mean

a <- 3
name2 <- "Why hello there!"

# typeof
# mode(a)
# length(my.data)
# is.na(my.data)

# log10(100)
# log10(c(1:100))

# seq(0, 1, length.out = 100)
# rep(1:3, each=4)
# sample(1:10)

plot(cos(seq(0,1 , 0.01)))
mean(1,3)
