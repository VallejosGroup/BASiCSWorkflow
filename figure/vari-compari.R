library("ggplot2")
ncells <- 100
m1 <- 1
m2 <- 2
sd1 <- 1
sd2 <- 1
x1 <- rnorm(ncells, m1, sd1)
x2 <- rnorm(ncells, m2, sd2)
cm <- ceiling(max(abs(x1), abs(x2)))
g1 <- ggplot(data.frame(x = 0)) +
  stat_function(
    aes(colour = "Group A"),
    fun = dnorm,
    args = c(mean = m1, sd = sd1),
    linewidth = 2
  ) +
  stat_function(
    aes(colour = "Group B"),
    fun = dnorm,
    args = c(mean = m2, sd = sd2),
    linewidth = 2
  ) +
  geom_text(
    data = data.frame(
      colour = c("Group A", "Group B"),
      label = c("Group A", "Group B"),
      x = c(m1 - 1, m2 + 1),
      y = c(0.4, 0.4)
    ),
    aes(x = x, y = y, colour = colour, label = label),
    fontface = "bold"
  ) +
  # geom_vline(xintercept = m1, linetype = "dashed", colour = "grey60") +
  # geom_vline(xintercept = m2, linetype = "dashed", colour = "grey60") +
  xlim(min(x1), max(x2)) +
  scale_colour_brewer(palette = "Set1") +
  theme_classic() +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
  )
g2 <- ggplot() +
  geom_jitter(
    aes(x1, 1, fill = "a"),
    width = 0,
    height = 0.05,
    shape = 21,
    size = 3,
    colour = "black"
  ) +
  geom_jitter(
    aes(x2, 2, fill = "b"),
    width = 0,
    height = 0.05,
    shape = 21,
    size = 3,
    colour = "black"
  ) +
  scale_colour_brewer(palette = "Set1", aesthetics = "fill") +
  labs(x = "Expression", y = NULL) +
  theme_classic(base_size = 15) +
  # geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  coord_cartesian(xlim = c(min(x1), max(x2)), ylim = c(0.5, 2.5)) +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
    # , axis.title = element_blank(),
  )
cowplot::plot_grid(g1, g2, align = "v", ncol = 1)
