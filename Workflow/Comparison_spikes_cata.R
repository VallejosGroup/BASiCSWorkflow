
# Load chains from remote server
website <- "https://jmlab-gitlab.cruk.cam.ac.uk/publications/"
folder <- "BASiCSWorkflow2018/raw/master/MCMCs/"
file <- "MCMC_naive.rds"
MCMC.naive1 <- readRDS(file = url(paste(website, folder, file, sep = "")))
MCMC.naive1

# MCMC.naive was calculated suing the new concentrations

SummaryOld <- Summary(MCMC.naive1)
SummaryNew <- Summary(MCMC.naive)


ess <- coda::effectiveSize(coda::mcmc(displayChainBASiCS(MCMC.naive, "mu")))
high_ess_genes <- names(ess[ess > 500])
selectGenes <- which(ess > 500)

smoothScatter(log10(displaySummaryBASiCS(SummaryOld, Param = "mu")[selectGenes,1]),
              log10(displaySummaryBASiCS(SummaryNew, Param = "mu")[selectGenes,1]))
abline(a = 0, b = 1, col = "red")

smoothScatter(log10(displaySummaryBASiCS(SummaryOld, Param = "delta")[selectGenes,1]),
              log10(displaySummaryBASiCS(SummaryNew, Param = "delta")[selectGenes,1]))
abline(a = 0, b = 1, col = "red")

smoothScatter(displaySummaryBASiCS(SummaryOld, Param = "epsilon")[selectGenes,1],
              displaySummaryBASiCS(SummaryNew, Param = "epsilon")[selectGenes,1])
abline(a = 0, b = 1, col = "red")

smoothScatter(displaySummaryBASiCS(SummaryOld, Param = "s")[,1],
              displaySummaryBASiCS(SummaryNew, Param = "s")[,1])
abline(a = 0, b = 1, col = "red")

BASiCS_showFit(MCMC.naive)
BASiCS_showFit(MCMC.naive1)
