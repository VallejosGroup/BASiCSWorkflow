library("ggplot2")
library("latex2exp")

set.seed(42)
mu <- rlnorm(10000, 3)
x <- rpois(10000, abs(rnorm(10000, mu, 2)))
y <- rpois(10000, abs(rnorm(10000, mu, 2)))

x <- log1p(x)
y <- log1p(y)


l <- range(c(x, y))

ggplot() +
    aes(x, y) +
    geom_point(size=0.5, colour = "grey60") +
    geom_segment(
        aes(x = 4, xend = 4.75, y = 4.75, yend = 4),
        linewidth = 0.5,
        arrow = arrow(length = unit(0.03, "npc")),
        colour = "firebrick"
    ) +
    geom_segment(
        aes(x = 4.75, xend = 4, y = 4, yend = 4.75),
        linewidth = 0.5,
        arrow = arrow(length = unit(0.03, "npc")),
        colour = "firebrick"
    ) +
    annotate(
        geom = "text", x = 4, y = 5,
        label = TeX("$\\theta$"),
        size = 6,
        fontface = "bold",
        colour = "firebrick"
    ) +
    theme_classic(base_size = 12) +
    labs(x = "Replicate 1", y = "Replicate 2")

ggsave("theta.png", width = 3, height = 3)
