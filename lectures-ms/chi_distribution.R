library(ggplot2)
library(latex2exp)

check_device <- function() {
  while (!is.null(dev.list())) Sys.sleep(1)
}

X11()
p <- ggplot(data.frame(x = c(0, 15)), aes(x = x)) +
  stat_function(
    fun = dchisq, args = list(df = 1),
    aes(colour = "n = 1")
  )
p <- p + stat_function(fun = dchisq, args = list(df = 2), aes(colour = "n = 2"))
p <- p + stat_function(fun = dchisq, args = list(df = 6), aes(colour = "n > 2")) # n > 2
p <- p + scale_colour_manual("", values = c("green", "purple", "red"))
p <- p + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) + theme(
  axis.text.x = element_blank(),
  axis.ticks.x = element_blank()
)
p <- p + ggtitle("") + xlab(label = "x") + ylab(label = TeX("$f_{y}(x, n)$")) + theme(
  axis.text = element_text(colour = "red"),
  axis.title = element_text(colour = "blue")
)
p
check_device()
