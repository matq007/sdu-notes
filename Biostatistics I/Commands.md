# Commands

```R
read.table()	# reads table
mode()			# check type
length()		# length of object
is.na()			# is NULL
is.numeric()	
is.matrix()
as.numeric()	# typecast to numeric
c()				# concat
seq()			# generates vector <from, to>
rep()			
sample()		# random vector <from, to>
mean()
sum()
median()
sd()			# standart deviation
max(), min()
dim()
class()
data()			# loads data from som library usually
sort()
merge()
by()			# carry out command for each row/column
apply()
paste()			# string
grep()			# search
strsplit()
sub()			# substitution

# Sets
union(), intersect()
unique(), diplicated()
A %in% B
```

### Math

```R
+, -, *, /, ^, %%, %/%
5 / 2	# 2.5
5 %% 2	# 1	(modulo)
5 %/% 2	# 2 (devide => integer)
```

### Collections

```R
list()
data.frame()
cbind()			# matrices
```

### Loops

```R
while (a < 10) {
    a <- a + 1
}

for (i in 1:100) {
    print i
}

```

### Functions

```R
myfunc <- function (arg1, arg2) {
  command
}
```

### Packages

```r
install.package("package")
source("http://")			# link to the lib
library(lib)				# load the lib
```

### Plot

```R
xlim = c(0, 1)
ylim = c(0, 1)
xlab = "Moja manka vari lepsie ako tvoja"

points()
lines()
abline()	# add straight line
legend()
par()
pairs()

# Plot types
hist()
boxplot()
```

### Graphical output

```R
pdf()
png()
windows()
x11()
quartz()
```

