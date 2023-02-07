library(ggplot2)
library(latex2exp)

check_device <- function()
{
    while (!is.null(dev.list())) Sys.sleep(1)
}
dt2 <- function(x, mu, nu, df, ncp) {
      dt((x-mu)/nu,df,ncp)/nu
}

set.seed(0)
x <- data.frame(rt(5000,df=5,ncp=1)*10+7)
names(x) <- c("test.data")

X11()
p <- ggplot(x, aes(x=test.data)) + stat_function(fun = dt2, args=list(mu=50, nu=10, df=1, ncp=1), aes(colour = "n = 1"))
p <- p + stat_function(fun = dt2, args=list(mu=50, nu=10, df=5, ncp=1), aes(colour = "n = 5"))
p <- p + stat_function(fun = dt2, args=list(mu=50, nu=10, df=1000000, ncp=1), aes(colour = "n = inf"))
p <- p + scale_colour_discrete("", labels=c("n = 1", "n = 5", TeX("$n = \\infty$")))
p <- p + theme(axis.text.y=element_blank(), axis.ticks.y=element_blank()) + theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
p <- p + ggtitle("") + xlab(label="x") + ylab(label=TeX("$f_{Y}(x, n)$")) + theme(axis.text=element_text(colour="red"),
                                                                                      axis.title=element_text(colour="blue"))
p
check_device()
