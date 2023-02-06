library(ggplot2)
library(latex2exp)

check_device <- function()
{
    while (!is.null(dev.list())) Sys.sleep(1)
}

histo <- function(data)
{
    # p <- ggplot(data.frame("x"=c(-3, data[1, 1]), "f"=c(0, 0)), mapping=aes(x=x, y=f)) + geom_line()
    p <- ggplot() + geom_vline(xintercept=0) + geom_hline(yintercept=0)
    for(i in 1:(length(data[, 1])-1))
    {
        p <- p + geom_line(data.frame("x"=c(data[i, 1], data[i+1, 1]), "f"=c(data[i, 2], data[i, 2])), mapping=aes(x=x, y=f)) 
        print(paste("data[i, 1], data[i+1, 1] : ", data[i, 1], data[i+1, 1]))
        print(i)
    }
    p <- p + geom_line(data.frame("x"=c(data[1, 1], data[1, 1]), "f"=c(data[1, 2], 0)), mapping=aes(x=x, y=f), linetype="dashed", colour="grey")
    for(i in 2:(length(data[, 1])-1))
    {
        if(data[i, 2] > data[i-1, 2])
        {
            p <- p + geom_line(data.frame("x"=c(data[i, 1], data[i, 1]), "f"=c(data[i, 2], 0)), mapping=aes(x=x, y=f), linetype="dashed", colour="grey")
        } else # if current point value is less then previous
        {
            p <- p + geom_line(data.frame("x"=c(data[i, 1], data[i, 1]), "f"=c(data[i-1, 2], 0)), mapping=aes(x=x, y=f), linetype="dashed", colour="grey")
        }
    }
    p <- p + geom_line(data.frame("x"=c(data[length(data[, 1]), 1], data[length(data[, 1]), 1]), "f"=c(data[length(data[, 1])-1, 2], 0)), mapping=aes(x=x, y=f), linetype="dashed", colour="grey")
    p
}

data <- data.frame("x"=c(seq(-2, 3, 1)), "f"=0)
for(i in 1:length(data[, 1]))
{
    data[i, 2] <- abs(runif(1, min=0, max=1))
}
data[length(data[, 1]), 2] <- 0 # for expl: in 5 points we have 4 bins
data
X11()
histo(data)
check_device()
