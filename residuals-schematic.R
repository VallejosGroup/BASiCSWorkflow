library("ggplot2")
library("latex2exp")
set.seed(42)

x <- rnorm(100)
y <- rnorm(100, -2 * x)
df <- data.frame(x, y)

gam <- mgcv::gam(y ~ s(x, bs = "cs"), data = df)
df$pred <- predict(gam, newdata=df)
df$less <- df$pred < df$y

pick <- df[order(abs(df$y - df$pred), decreasing=TRUE)[3], ]



ggplot() +
    geom_smooth(data=df, mapping = aes(x, y), colour = "grey50", method = "gam", formula = y ~ s(x, bs = "cs")) +
    geom_segment(
        aes(x = x, y = pred, xend = x, yend = y - 0.1 * less + 0.1 * (1 - less)),
        data = pick,
        colour = "firebrick",
        # linetype = "dashed",
        arrow = arrow(length = unit(.2, 'cm')),
        linewidth = 0.7,
        inherit.aes = FALSE
    ) +
    annotate(
        "text",
        x = pick$x + 0.1,
        y = pick$y - 0.8,
        label = TeX("Residual \noverdispersion $\\epsilon_i$"),
        colour = "firebrick",
        # fontface = "bold",
        hjust = 0,
        vjust = 0,
        size = 4.5
    ) +
    geom_point(data = df, mapping = aes(x, y), size = 0.7) +
    labs(x = TeX("Mean expression $\\mu_i$"), y = TeX("Overdispersion $\\delta_i$")) +
    theme_classic() +
    coord_cartesian(xlim = c(-1.5, 1.5), ylim = c(-4, 4)) +
    theme(
        axis.text = element_blank(), axis.ticks = element_blank(),
        text = element_text(size = 15, face = "bold")
    )
ggsave("residuals.pdf", width = 3.5, height = 3)
