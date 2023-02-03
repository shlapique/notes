library(ggplot2)
library(latex2exp)

check_device <- function()
{
    while (!is.null(dev.list())) Sys.sleep(1)
}

plotter <- function(data)
{
    # first and last 'x' on graph (for pretty look in pdf)
    first <- 0
    last  <- 0
    print("OUT OF PLOTTER")
    dash_data <- data.frame() # vertical dashed lines
    dash_data_tmp <- dash_data
    for(i in 1:(length(data[, 1])-1))
    {
        print(paste("i = ",i, " data[i, 2] = ", data[i, 2], " data[i + 1, 2] = ", data[i + 1, 2]))
        if(data[i, 2] != data[i + 1, 2])
        {
            dash_data_tmp <- dash_data
            dash_data <- rbind(dash_data_tmp, data.frame("x"=c(data[i, 1], data[i, 1]), "f"=c(data[i, 2], data[i+1, 2])))
            last <- i
            first <- last - length(dash_data[, 1]) / 2
        }
    }
    last <- last + 1
    print("DAASH DATA IS")
    print(dash_data)
    print(paste("LAST = ", last, "FIRST = ", first))
    p <- ggplot(data.frame("x"=c(data[first, 1], dash_data[1, 1]), "f"=c(data[first, 2], dash_data[1, 2])), mapping=aes(x=x, y=f)) + geom_line() + geom_point(data.frame("x"=c(dash_data[1, 1]), "f"=c(dash_data[1, 2])), mapping=aes(x=x, y=f), shape=21, size=3, fill="white")
    j <- 1
    m <- 2 
    while(j <= length(dash_data[, 1]))
    {
        data_tmp <- data.frame("x"=c(dash_data[j, 1], dash_data[j+1, 1]), "f"=c(dash_data[j, 2], dash_data[j+1, 2]))
        p <- p + geom_line(data_tmp, mapping=aes(x=x, y=f), linetype="dashed")
        if(m+1 != length(dash_data[, 1])+1)
        {
            print(paste("M : ", m))
            data_tmp <- data.frame("x"=c(dash_data[m, 1], dash_data[m+1, 1]), "f"=c(dash_data[m, 2], dash_data[m+1, 2]))
            p <- p + geom_line(data_tmp, mapping=aes(x=x, y=f)) + geom_point(data.frame("x"=c(dash_data[m+1, 1]), "f"=c(dash_data[m+1, 2])), mapping=aes(x=x, y=f), shape=21, size=3, fill="white")
            m <- m + 2
        }
        j <- j + 2
    }
    p <- p + geom_line(data.frame("x"=c(dash_data[length(dash_data[,1]), 1], data[last, 1]), "f"=c(dash_data[length(dash_data[,1]), 2], data[last, 2])), mapping=aes(x=x, y=f))
    p <- p + scale_x_continuous(breaks=c(dash_data[1, 1], dash_data[3, 1], dash_data[length(dash_data[, 1])-2, 1], dash_data[length(dash_data[, 1]), 1]), labels=c(TeX("$X^{1}$"), TeX("$X^{2}$"), TeX("$X^{n-1}$"), TeX("$X^{n}$")))
    p <- p + scale_y_continuous(breaks=c(dash_data[2, 2], dash_data[length(dash_data[, 1])-1, 2], 1), labels=c(TeX("$\\frac{1}{n}$"), TeX("$\\frac{n - 1}{n}$"), TeX("$1$")))
    p + ggtitle("") + xlab(label="x") + ylab(label=TeX("$\\hat{F}_{n}(x)$"))
}

# if x >= X^{(1)}
flid <- function(n, data, x)
{
    max <- 0
    for(i in 1:length(data))
    {
        if(data[i] <= x && i > max)
        {
            max <- i
        }
    }
    return (1 / n * max)
}

por_stat <- function(n, x, sort_sample)
{
    X <- c()
    Y <- c()
    for(i in 1:length(x))
    {
        if(x[i] >= min(sort_sample))
        {
            X[i] <- x[i]
            Y[i] <- flid(n, sort_sample, x[i])
        } else 
        {
            X[i] <- x[i]
            Y[i] <- 0
        }
    }
    return (data.frame("x"=X, "f"=Y))
}


n <- 21 
x <- seq(-10, 10, 1)
y <- rnorm(n, 0, 1)
data <- por_stat(n, x, sort(y))
data
X11()
plotter(data)
check_device()
