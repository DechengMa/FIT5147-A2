library(ggplot2)
library(scales)
coralData <- read.csv('./assignment-02-data-formated.csv')

ggplot(coralData, aes(year, coralType)) + geom_point() + facet_wrap(location~value)

brks <- c(0, 0.5, 1)

ggplot(coralData, aes(year, value)) + 
  geom_point() +
  scale_y_discrete(breaks = seq(0, 1, by = 0.2)) +
  facet_grid(coralType~reorder(location, latitude)) +
  geom_smooth(aes(group = 1),
              method = "lm",
              color = "black",
              formula = y~ poly(x, 2),
              se = FALSE)

 

