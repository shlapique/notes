library(ggplot2)

check_device <- function()
{
    while (!is.null(dev.list())) Sys.sleep(1)
}

plotter <- function(data)
{
    print("OUT OF PLOTTER")
    dash_data <- data.frame()
    dash_data_tmp <- dash_data
    for(i in 1:(length(data[, 1])-1))
    {
        print(paste("i = ",i, " data[i, 2] = ", data[i, 2], " data[i + 1, 2] = ", data[i + 1, 2]))
        if(data[i, 2] != data[i + 1, 2])
        {
            dash_data_tmp <- dash_data
            dash_data <- rbind(dash_data_tmp, data.frame("x"=c(data[i, 1], data[i, 1]), "f"=c(data[i, 2], data[i+1, 2])))
            # ggplot(data.frame("x"=c(data[i, 1], data[i, 1]), "f"=c(data[i, 2], data[i+1, 2])), mapping=aes(x=x, y=f)) + geom_line(linetype="dashed")
        }
    }
    print("DAASH DATA IS")
    print(dash_data)
    ggplot(dash_data, aes(x=x, y=f)) + geom_line(linetype="dashed")
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

n <- 11
x <- seq(-5, 5, 1)
y <- rnorm(n, 0, 1)
data <- por_stat(n, x, sort(y))
data
plotter(data)
