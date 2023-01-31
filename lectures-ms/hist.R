library(ggplot2)

check_device <- function()
{
    while (!is.null(dev.list())) Sys.sleep(1)
}

l <- 6 
set.seed(0)
data <- data.frame(x=rnorm(30))
data

X11()
ggplot(data, aes(x)) + geom_histogram(aes(y=after_stat(density)), fill='lightblue', col='black', bins=l)
check_device()

