library(ggplot2)
library(latex2exp)

check_device <- function() {
    while (!is.null(dev.list())) Sys.sleep(1)
}

m <- 4
n <- 15
break_x <- ((n - 2) * m)/(n * (m + 2))
break_y <- df(break_x, n, m)

X11()
p <- ggplot(data.frame(x = c(0, 5)), aes(x = x)) + stat_function(fun = df, args = list(df1 = n,
    df2 = m), aes(colour = "n > 2"))
p <- p + geom_line(data.frame(x = c(0, 0), f = c(0, break_y)), mapping = aes(x = x,
    y = f), arrow = arrow(length = unit(0.01, "npc"), type = "closed"))
p <- p + geom_line(data.frame(x = c(0, 6), f = c(0, 0)), mapping = aes(x = x, y = f),
    arrow = arrow(length = unit(0.01, "npc"), type = "closed"))
p <- p + scale_colour_manual("", values = c("green"))
p <- p + ggtitle("") + xlab(label = "x") + ylab(label = TeX("$f_{y}(x, n, m)$")) +
    theme(axis.text = element_text(colour = "red"), axis.title = element_text(colour = "blue"))
p <- p + scale_x_continuous(breaks = c(0, break_x), label = c("0", TeX("$\\frac{(n-2)m}{n(m+2)}$")))
p <- p + geom_line(data.frame(x = c(break_x, break_x), f = c(0, break_y)), mapping = aes(x = x,
    y = f), linetype = "dashed")
p <- p + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
p
check_device()
