setwd("~/School/SDU/Biostatistics I/")

# VECTOR
vector("numeric", 3)
1:10
myvec <- sample(1:100)
length(myvec)
names(myvec)
names(myvec) <- paste("A", 1:100)

myvec[c(1:11, 13)]

myvec2 <- c(2,6,3)
myvec2[myvec2 == 6]
myvec[myvec > 10 & myvec < 20]

myvec[c("A 95", "A 1")]

# MATRIX

mymatr <- matrix(1:12, 3, 4)
mymatr
rownames(mymatr) <- LETTERS[1:3]
colnames(mymatr) <- letters[1:4]

mymatr[1:2, "d"]
mymatr[c("A", "C"), "d"]

dim(mymatr)

# DATAFRAME
datframe <- data.frame(A = 1:10, B = letters[1:10], stringsAsFactors = FALSE)
datframe
mode(datframe[,2])

datframe[-2, 2]

datframe[, "A"]
datframe$A

list()
mylist <- list(zero = 0, number=1:10, bool=c(T,F,T,T))
mylist[[2]]
mylist[[2]][4]

names(mylist)
