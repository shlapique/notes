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
    # p <- p + scale_x_continuous(breaks=c(data[seq(1, 5, 1), 1]), labels=c(TeX("t_{1}"), TeX("t_{1}"), TeX("t_{1}"), TeX("t_{1}"), TeX("t_{1}")))
    p <- p + scale_x_continuous(breaks=c(data[seq(1, 5, 1), 1]), labels=TeX(sprintf(r'($t_{%d}$)', 1:5)))

    p <- p + ggtitle("") + xlab(label="x") + ylab(label=TeX("$\\hat{f}_{n}(x)$")) + theme(axis.text=element_text(colour="red"),
                                                                                          axis.title=element_text(colour="blue"))
    p <- p + theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())
    p
}

data <- data.frame("x"=c(seq(-0.7, 0.5, 0.3)), "f"=0)
set.seed(0)
for(i in 1:length(data[, 1]))
{
    data[i, 2] <- abs(runif(1, min=0, max=1))
}
data[length(data[, 1]), 2] <- 0 # for expl: in 5 points we have 4 bins
data
X11()
histo(data)
check_device()
