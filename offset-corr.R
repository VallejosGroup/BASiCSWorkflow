library("BASiCS")

Chain1 <- readRDS("rds/chain_active.Rds")
Chain2 <- readRDS("rds/chain_naive.Rds")


GroupLabel1 <- "Group 1"
GroupLabel2 <- "Group 2"

L <- BASiCS_CorrectOffset(Chain1, Chain2)
OffsetChain <- L$OffsetChain
OffsetEst <- L$Offset
Chain1_offset <- L$Chain
Chain2_offset <- Chain2
Mu1 <- matrixStats::colMedians(Chain1_offset@parameters$mu)
Mu2 <- matrixStats::colMedians(Chain2@parameters$mu)
Mu1_old <- matrixStats::colMedians(Chain1@parameters$mu)
n1 <- ncol(Chain1@parameters$nu)
n2 <- ncol(Chain2@parameters$nu)
n <- n1 + n2
MuBase <- (Mu1 * n1 + Mu2 * n2)/n

ylim <- c(0.1, 500)
# ylim <- range(c(Mu1_old, Mu1, Mu2))
df <- cbind(Mu1_old, Mu2)
colnames(df) <- c(GroupLabel1, GroupLabel2)
mdf <- reshape2::melt(df)
g1 <- ggplot(mdf, aes(x = .data$Var2, y = .data$value)) + 
    labs(title = "Overall shift", y = "Mean expression", x = NULL) +
    geom_boxplot(fill = "grey80", outlier.color = NA, na.rm = TRUE) +
    scale_y_log10(limits = ylim) +
    theme_classic() +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
df <- cbind(Mu1, Mu2)
colnames(df) <- c(GroupLabel1, GroupLabel2)
mdf <- reshape2::melt(df)
g2 <- ggplot(mdf, aes(x = .data$Var2, y = .data$value)) + 
    labs(title = "After correction", y = NULL, x = NULL) +
    geom_boxplot(fill = "grey80", outlier.color = NA) +
    scale_y_log10(limits = ylim) +
    theme_classic() +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
cowplot::plot_grid(g1, g2)
ggsave("offsets.pdf", width = 3.5, height = 3)

## make offset more obvious
