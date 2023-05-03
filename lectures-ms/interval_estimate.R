library(ggplot2)
library(latex2exp)
library(tibble)

check_device <- function() {
  while (!is.null(dev.list())) Sys.sleep(1)
}

X11()
data <- data.frame(x = c(-5, -3, 0, 3, 5), y = 0)

ggplot(data, aes(x, y)) +
  geom_line(aes(y = y), arrow = arrow(length = unit(
    0.01,
    "npc"
  ), type = "closed")) +
  geom_point(data.frame(x = c(-3, 0, 3), y = 0), mapping = aes(x = x)) +
  geom_line(data.frame(x = c(-3, 3), y = 0), mapping = aes(x = x), linewidth = 10, colour = "red", alpha = 0.3) +
  annotate("text",
    x = -4.5, y = 0, label = TeX("$- \\frac{\\alpha}{2}$", output = "character"),
    vjust = -1, size = 5, parse = TRUE
  ) +
  annotate("text", x = -3, y = 0, label = TeX("$\\hat{\\theta}_{1}(Z_{n})$",
    output = "character"
  ), vjust = 2, size = 5, parse = TRUE) +
  annotate("text",
    x = 0, y = 0, label = TeX("$\\theta$", output = "character"), vjust = 2, size = 6,
    parse = TRUE
  ) +
  annotate("text",
    x = 0, y = 0, label = TeX("$1 - \\alpha$", output = "character"),
    vjust = -2, size = 6, parse = TRUE
  ) +
  annotate("text", x = 3, y = 0, label = TeX("$\\hat{\\theta}_{2}(Z_{n})$",
    output = "character"
  ), vjust = 2, size = 5, parse = TRUE) +
  annotate("text",
    x = 4.5, y = 0, label = TeX("$\\frac{\\alpha}{2}$", output = "character"), vjust = -1,
    size = 5, parse = TRUE
  ) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
  theme(plot.title = element_blank())
check_device()
