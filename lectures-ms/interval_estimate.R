library(ggplot2)

my_df <- data.frame(y=c("krol", "pena"))
ggplot(my_df, aes(x=mpg, y=0)) +
  geom_line(linewidth=1) +
  geom_point(shape = 108, size= 5) +
  geom_text(aes(label=manufacturer),hjust=0.5, vjust=-2)+
  geom_text(aes(label=mpg),hjust=.5, vjust=2) +
  theme_void()
  theme(axis.line.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),
          panel.grid.minor.y=element_blank(),
          panel.grid.major.y=element_blank())
