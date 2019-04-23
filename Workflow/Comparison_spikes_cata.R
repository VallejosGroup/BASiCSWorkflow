
chains.path <- "~/Documents/OneDrive/Projects/SingleCell/BASiCS/Chains/Workflow"

library(BASiCS)

# Loading chains for naive cells

# Loading chain generated with the first ERCC calculation
ChainN1 <- readRDS(file = file.path(chains.path, "MCMC_naive_first.rds"))
# Loading chain generated with the second ERCC calculation
ChainN2 <- readRDS(file = file.path(chains.path, "MCMC_naive_second.rds"))
# Loading chain generated with the new ERCC calculation
ChainN3 <- readRDS(file = file.path(chains.path, "MCMC_naive_current.rds"))
# Loading chain generated with the first ERCC calculation - long run
# Note: accidentally run with Regression = FALSE
ChainN4 <- readRDS(file = file.path(chains.path, "chain_naive_long.rds"))

# Fix no longer required from version 1.5.32
ChainN4@parameters <- ChainN4@parameters[!grepl("ls.", names(ChainN4@parameters))]

# Calculating the associated posterior summaries
SummaryN1 <- Summary(ChainN1)
SummaryN2 <- Summary(ChainN2)
SummaryN3 <- Summary(ChainN3)
SummaryN4 <- Summary(ChainN4)

# Calculating ESS for mean parameters
essN1 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainN1, "mu")))
essN2 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainN2, "mu")))
essN3 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainN3, "mu")))
essN4 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainN4, "mu")))


DF1 <- data.frame("mu1" = displaySummaryBASiCS(SummaryN1, Param = "mu")[,1],
                  "mu2" = displaySummaryBASiCS(SummaryN2, Param = "mu")[,1],
                  "mu3" = displaySummaryBASiCS(SummaryN3, Param = "mu")[,1],
                  "mu4" = displaySummaryBASiCS(SummaryN4, Param = "mu")[,1],
                  "delta1" = displaySummaryBASiCS(SummaryN1, Param = "delta")[,1],
                  "delta2" = displaySummaryBASiCS(SummaryN2, Param = "delta")[,1],
                  "delta3" = displaySummaryBASiCS(SummaryN3, Param = "delta")[,1],
                  "delta4" = displaySummaryBASiCS(SummaryN4, Param = "delta")[,1],
                  "epsilon1" = displaySummaryBASiCS(SummaryN1, Param = "epsilon")[,1],
                  "epsilon2" = displaySummaryBASiCS(SummaryN2, Param = "epsilon")[,1],
                  "epsilon3" = displaySummaryBASiCS(SummaryN3, Param = "epsilon")[,1],
                  #"epsilon4" = displaySummaryBASiCS(SummaryN4, Param = "epsilon")[,1],
                  "ess1" = essN1, "ess2" = essN2, "ess3" = essN3, "ess4" = essN4)

library(ggplot2)
library(cowplot)
library(viridis)

# Mean vs ESS
p1 <- BASiCS_diagPlot(ChainN1, Param = "mu") + scale_y_log10()
p2 <- BASiCS_diagPlot(ChainN2, Param = "mu") + scale_y_log10()
p3 <- BASiCS_diagPlot(ChainN3, Param = "mu") + scale_y_log10()
p4 <- BASiCS_diagPlot(ChainN4, Param = "mu") + scale_y_log10()
p1 <- p1 + ggtitle("First ERCC calculation")
p2 <- p2 + ggtitle("Second ERCC calculation")
p3 <- p3 + ggtitle("Current ERCC calculation")

plot_grid(p1, p2, p3, ncol = 3)

# Select a gene for which ESS was very low and explore chains
plot(ChainN1, Param = "mu", Gene = which(DF1$ess1 < 10)[1])
plot(ChainN2, Param = "mu", Gene = which(DF1$ess1 < 10)[1])
plot(ChainN3, Param = "mu", Gene = which(DF1$ess1 < 10)[1])
plot(ChainN4, Param = "mu", Gene = which(DF1$ess1 < 10)[1])

# Comparison of point estimates
p1 <- ggplot(DF1, aes(x = mu3, y = mu1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation") + ggtitle("Mean parameters") + geom_abline()

p2 <- ggplot(DF1, aes(x = mu2, y = mu1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("Second ERCC calculation") + ggtitle("Mean parameters") + geom_abline()

p3 <- ggplot(DF1, aes(x = delta3, y = delta1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation") + ggtitle("Dispersion parameters") + geom_abline()

p4 <- ggplot(DF1, aes(x = delta2, y = delta1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") +  
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("Second ERCC calculation") + ggtitle("Dispersion parameters") + geom_abline()

p5 <- ggplot(DF1, aes(x = epsilon3, y = epsilon1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  xlab("Current ERCC calculation") +
  ylab("First ERCC calculation") + ggtitle("Residual parameters") + geom_abline()

p6 <- ggplot(DF1, aes(x = epsilon2, y = epsilon1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") +  
  xlab("Current ERCC calculation") +
  ylab("Second ERCC calculation") + ggtitle("Residual parameters") + geom_abline()

p7 <- ggplot(DF1, aes(x = mu4, y = mu1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation - long") + ggtitle("Mean parameters") + geom_abline()

p8 <- ggplot(DF1, aes(x = delta4, y = delta1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation - long") + ggtitle("Dispersion parameters") + geom_abline()

plot_grid(p1, p2, p3, p4, p5, p6, ncol = 2)

# LogFC vs ESS

p1 <- ggplot(DF1, aes(x = ess1, y = log2(mu3/mu1))) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + xlab("Overall expression") + geom_hline(yintercept = 0) +
  ylab("Current/First ERCC calculation log2FC") + ggtitle("Mean parameters") 

p2 <- ggplot(DF1, aes(x = ess2, y = log2(mu3/mu2))) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + xlab("Overall expression") + geom_hline(yintercept = 0) +
  ylab("Current/Second ERCC calculation log2FC") + ggtitle("Mean parameters") 

p3 <- ggplot(DF1, aes(x = ess1, y = log2(delta3/delta1))) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + xlab("Overall expression") + geom_hline(yintercept = 0) +
  ylab("Current/First ERCC calculation log2FC") + ggtitle("Dispersion parameters") 

p4 <- ggplot(DF1, aes(x = ess2, y = log2(delta3/delta2))) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + xlab("Overall expression") + geom_hline(yintercept = 0) +
  ylab("Current/Second ERCC calculation log2FC") + ggtitle("Dispersion parameters") 

plot_grid(p1, p2, p3, p4)

# Comparison of point estimates, restricted to high ESS
p1 <- ggplot(DF1[DF1$ess1 > 800, ], aes(x = mu3, y = mu1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation") + ggtitle("Mean parameters")  + geom_abline()

p2 <- ggplot(DF1[DF1$ess1 > 800, ], aes(x = mu2, y = mu1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("Second ERCC calculation") + ggtitle("Mean parameters")  + geom_abline()

p3 <- ggplot(DF1[DF1$ess1 > 800, ], aes(x = delta3, y = delta1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") + 
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("First ERCC calculation") + ggtitle("Dispersion parameters") + geom_abline()

p4 <- ggplot(DF1[DF1$ess1 > 800, ], aes(x = delta2, y = delta1)) + geom_hex() + 
  scale_fill_viridis(name = "Count", trans = "log10") +  
  scale_x_log10() + scale_y_log10() + xlab("Current ERCC calculation") +
  ylab("Second ERCC calculation") + ggtitle("Dispersion parameters") + geom_abline()

plot_grid(p1, p2, p3, p4)


# Loading chains for active cells

# Loading chain generated with the first ERCC calculation
ChainA1 <- readRDS(file = file.path(chains.path, "MCMC_active_first.rds"))
# Loading chain generated with the second ERCC calculation
ChainA2 <- readRDS(file = file.path(chains.path, "MCMC_active_second.rds"))
# Loading chain generated with the new ERCC calculation
ChainA3 <- readRDS(file = file.path(chains.path, "MCMC_active_current.rds"))

# Calculating the associated posterior summaries
SummaryA1 <- Summary(ChainA1)
SummaryA2 <- Summary(ChainA2)
SummaryA3 <- Summary(ChainA3)

# Calculating ESS for mean parameters
essA1 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainA1, "mu")))
essA2 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainA2, "mu")))
essA3 <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(ChainA3, "mu")))

DF2 <- data.frame("mu1" = displaySummaryBASiCS(SummaryA1, Param = "mu")[,1],
                  "mu2" = displaySummaryBASiCS(SummaryA2, Param = "mu")[,1],
                  "mu3" = displaySummaryBASiCS(SummaryA3, Param = "mu")[,1],
                  "delta1" = displaySummaryBASiCS(SummaryA1, Param = "delta")[,1],
                  "delta2" = displaySummaryBASiCS(SummaryA2, Param = "delta")[,1],
                  "delta3" = displaySummaryBASiCS(SummaryA3, Param = "delta")[,1],
                  "ess1" = essA1, "ess2" = essA2, "ess3" = essA3)




MCMC.naive <- BASiCS_MCMC(Data = Data.naive, 
                          N = 400000, 
                          Thin = 200, 
                          Burn = 200000, 
                          Regression = TRUE, 
                          WithSpikes = TRUE,
                          StoreChains = TRUE,
                          StoreAdapt = TRUE,
                          StoreDir = chains.path,
                          RunName = "naive_long_reg")
