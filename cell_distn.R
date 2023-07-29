library("ggplot2")
library("latex2exp")

set.seed(11)

ncells <- 100
m1 <- 1
sd1 <- 1
r <- c(m1 - 3 * sd1, m1 + 3 * sd1)
x1 <- rnorm(ncells, m1, sd1)
g1 <- ggplot(data.frame(x = 0)) +
  stat_function(
    aes(colour = "Group A"),
    fun = dnorm,
    args = c(mean = m1, sd = sd1),
    linewidth = 2
  ) +
  geom_segment(
    aes(x = m1, y = 0, xend = m1, yend = 0.3),
    colour = "grey60",
    arrow = arrow(length = unit(.4, 'cm')),
    linewidth = 1,
    inherit.aes = FALSE
  ) +
  annotate(
    "text",
    x = m1,
    y = 0.3,
    label = TeX("$\\mu_i$"),
    # fontface = "bold",
    hjust = 0.5,
    vjust = -0.25,
    size = 7
  ) +
  geom_segment(
    aes(x = r[[1]], y = 0.42, xend = r[[2]], yend = 0.42),
    colour = "grey60",
    arrow = arrow(length = unit(.4, 'cm')),
    linewidth = 1,
    inherit.aes = FALSE
  ) +
  geom_segment(
    aes(x = r[[2]], y = 0.42, xend = r[[1]], yend = 0.42),
    colour = "grey60",
    arrow = arrow(length = unit(.4, 'cm')),
    linewidth = 1,
    inherit.aes = FALSE
  ) +
  annotate(
    "text",
    x = m1,
    y = 0.4,
    label = TeX("$\\delta_i$"),
    # fontface = "bold",
    hjust = 0.5,
    vjust = -0.5,
    size = 7
  ) +
  xlim(r[[1]], r[[2]]) +
  ylim(0, 0.475) +
  scale_colour_brewer(palette = "Set1") +
  theme_void() +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
  ) +
  NULL
g2 <- ggplot() +
  geom_jitter(
    aes(x1, 1, fill = "a"),
    width = 0,
    height = 0.05,
    shape = 21,
    size = 3,
    colour = "black"
  ) +
  scale_colour_brewer(palette = "Set1", aesthetics = "fill") +
  labs(x = "Expression", y = NULL) +
  theme_void(base_size = 15) +
  # geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  coord_cartesian(xlim = c(r[[1]], r[[2]]), ylim = c(0.5, 1.5)) +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
    # , axis.title = element_blank(),
  ) +
  NULL
cowplot::plot_grid(g1, g2, align = "v", ncol = 1, rel_heights = c(0.9, 0.15))
ggsave("distn.pdf", width = 3.5, height = 3)
