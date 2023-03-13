library(ggplot2)
library(latex2exp)
library(tibble)

check_device <- function() {
    while (!is.null(dev.list())) Sys.sleep(1)
}

X11()
data <- data.frame(x = c(1, 2, 3), f = c(2, 3, 4))
p <- ggplot(data, mapping = aes(x = x, y =f)) + geom_line()
p
check_device()
