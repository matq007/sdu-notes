library(MASS)
Animals

install.packages("plotly")

library(ggplot2)
library(plotly)
install.packages("data.table")

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(p)