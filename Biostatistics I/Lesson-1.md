# Lesson 1

```R
# Set working directory or through session
setwd("") 

# Show all the data with the header
my.data <- read.table("ExampleFile.csv", sep = ",", fill = TRUE)

# Show data without the header
my.data <- read.table("ExampleFile.csv", sep = ",", fill = TRUE, header = TRUE, comment.char = "")

# Display first 6 lines
head(my.data)

# Easy read
my.data <- read.table("ExampleFile.csv")
```

### Functions

```R
mode(my.data) #typeof
length(), is.na(my.data), leg10(100)

# Advanced
seq(from, to, by)
plot()
rep(x, times)
sample(x, size)
mean(c(0:10, 50))
```



# Excercises

