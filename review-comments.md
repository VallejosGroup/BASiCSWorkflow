# Review 1

## Oliver M. Crook, Department of Statistics, University of Oxford, Oxford, UK

### Summary:
 
O’Callaghan and co-authors provide a workflow for the popular method BASiCS and its extensions. This workflow is intended to display the bioconductor infrastructure of BASiCS and provide a template for analysis for others to streamline their data analysis. I find the workflow quite comprehensive and takes me through the analysis points that I would expect to see. First of all, I must confess I am not an expert in processing scRNA data and so I cannot assess whether the choices of filtering, thresholding etc are up-to-date. I will leave this assessment to other reviewers. Here, I wish to focus my review on the communication of sophisticated methods presented, the Bayesian analysis, visualizations and the code. I believe this is an extremely valuable contribution to the scRNA community, the workflow community and applied Bayesians. I would also like to thank the authors’ attention to detail, I found the article well-written and logically structured. 

I would encourage you to update your version of R to 4.2 as the next version of Bioconductor will use this.

### General comments:

Whilst the method itself is presented technically in other papers, I don’t quite get a good picture of the model and its variants. Referring to the other papers I find myself confronted with lots of equations, whilst I can make my way through these details I think the intended users might struggle. The workflow might benefit from a narrative description or recipe that highlights its generative nature. A cartoon or graphic can be particularly insightful.

As good statisticians, we should incorporate experimental design into our models. I think before the data are introduced it would be useful to have a short description of the type of experiments that could be analysed with BASiCS, when BASiCS would be useful over other approaches, when not to apply BASiCS. What sort of data would it be optimal to collect if I wish to analysed it using BASiCS? How valuable are spike-ins for example?

I had to spend quite some time on the code chunks, working out what was going on. I think these could be decorated with useful comments so your intended user is allowed to be as lazy as possible (which is what you want so they will use your package!). This was particularly the case for the pre-processing and parameter estimation.

There are some quite long code chunks that I felt represented fairly repetitive tasks, mostly related to plotting. If you're using ggplot2 then you can write a function which returns a ggplot object with nice defaults and you can explain that it can be customized using the ggplot principles. I think the current style is written to allow this customization but I think it's currently unexplained and perhaps working against you. 

In the section of parameter estimation, the discussion on priors is quite brief and quite unclear currently. I’m not quite sure what the "joint prior" is here, I think your intended audience would appreciate a narrative description of these priors. The other choices of independent log Normal is also unclear. The logMean and logSd appear to be set automatically using the data - is that what you mean by Empirical Bayes here? When I dive deeper into changing the priors BASiCS_PriorParam is quite daunting. I think there are some helpful things you can do for your readers. For example, you explain whether the analysis is sensitive to the prior choice and generally how they affect the analysis. You could guide your users through a prior predictive check, in which you simulate parameters from the prior and then fake data from the likelihood. You could then show users how well calibrated their prior choices are. General advice of setting the prior or whether they should just leave these alone would be useful.

I assume that multiple chains are run, are there any MCMC diagnostics based on running parallel chains?

In a Bayesian analysis I expected to be able to manipulate posterior distributions or credible intervals. Maybe I missed it but can we visualize the full posterior distribution for \mu_i vs \delta_i and \mu_i vs \epsilon_i or some other parameters of interest?  

I think I haven’t quite grasped the "variance decomposition" the authors mention into biological and technical components. This could be \delta_i and \epsilon_i, but I feel I am missing something? I do not yet think the methods section is quite clear on this point.

For the volcano plots the posterior probability is quite bunched up, would this be better on the logit scale? Also It appears the probabilities concentrate around 0.5? Is there an intuitive explanation for this? Indeed, the distribution generated by hist(p2$data$ProbDiffMean) was quite unexpected, are these probabilities calibrated in any way?

You mention computational challenges in the discussion, what is lost by performing maximum likelihood estimation or maximum a posteriori estimation? Perhaps the weighted likelihood bootstrap or variant could be a useful approach, if you have lots of cores.

What are the challenges of applying this to scRNA data with spatial autocorrelation? It is common to now obtain expression data in such a context, does this additional confounding obstruct the model?

### Specific comments:

In the first code chunks, in `website <- " https …” I think there is an initial space which stops this from running correctly.

Remember to include spaces after commas e.g. [a, ] rather than [a,], it is much clearer to read.

I think it would be better to load all the packages at the beginning, I had to restart my session several times to install the packages that I realized I needed x% of the way through the workflow.

In figure 4, the axis dimensions of the PCA misrepresents the variance explained. The ratio of axis dimensions should closely match the ratios of the variance explained so that the visualization is faithful to the dimensionality reduction. 

Constants used in the package could be saved as global variables, it’s very easy to make a typo with these conversions.

In the chunk starting ## Moles per microliter, I had to edit the first line of the code chunk to get it to work. Perhaps it has been malformatted?

\log is a symbol and should always be lower-case

In the abstract, you write "strong technical noise". I don’t quite understand what "strong" is adding here. 

A number of concepts are left unexplained such as "joint prior", "negative binomial framework", "borrows information", "expected false discovery rate". These are all familiar concepts to someone with advanced statistical knowledge but the casual scRNA reader might find this off putting.
 
Figure 12 there is a typo in the legend "\log_{1}0 -> \log_{10}".

In Figure 12 the dendrogram is unexplained and I’m not sure what it means in this context.

    Is the rationale for developing the new software tool clearly explained?

    Yes

    Is the description of the software tool technically sound?

    Yes

    Are sufficient details of the code, methods and analysis (if applicable) provided to allow replication of the software development and its use by others?

    Yes

    Is sufficient information provided to allow interpretation of the expected output datasets and any results generated using the tool?

    Yes

    Are the conclusions about the tool and its performance adequately supported by the findings presented in the article?

    Yes

### Competing Interests

I receive funding from GlaxoSmithKline.

### Reviewer Expertise

Biostatistics, Bayesian methodology, R, data-intensive biology



# Review 2

##  Andrew McDavid, Department of Biostatistics and Computational Biology, University of Rochester, Rochester, NY, USA  

This is an extensive workflow on applying the authors' BASiCS method to a plate-based single-cell RNAseq data. The authors discuss preparing data downloaded from an external repository, evaluation of QC metrics, interrogation of convergence of a Bayesian model, interpretation of model parameters, and comparative tests in the two sample settings. Code to generate an expansive array of figures is provided.

All said, it's a comprehensive workflow demoing well-documented software. I do have a few concerns about how other users would apply the workflow to their data:

    The authors demo their method on some naive CD4 cells from inbred mice - really the ideal data set to illustrate a method looking at intrinsic sources of gene heterogeneity or homogeneity. How would prospective users of BASiCS adapt it to more typical datasets from droplet-based scRNAseq, either from samples with more heterogeneity (human) or of less purified cells, where spike-ins are absent and the "horizontal integration" model must be invoked? I am left wondering:
        a. What sort of QC would be needed?
        b. How should the data be stratified (into fairly fine-grained cell types on the basis of unsupervised clustering of the expression vector? Though this sort of double-dipping will change the inferential properties of the model).
        c. How can violations of the Bayesian model be detected, or of unresolved sub-population heterogeneity, indicating more clustering is needed?
        d. Given that with K populations, we'd have K-times the output from a single run of BASiCS to interpret. How to prioritize or understand it? (Perhaps an approach like muscat uses here would be helpful?1).
        e. What techniques can aid in fitting this computationally-intensive model on larger datasets (e.g. thousands of cells)? Should we downsample cells, or apply more aggressive pre-filtering of genes? I see there's some provision to apply a "divide and conquer strategy" to fit the model on tranches of the data in parallel. How should this be used in practice?
         
    The workflow is quite lengthy, enough that I found it hard to follow at times, and that I might be missing the forest for the trees. It would be nice if it could be condensed to emphasize model interpretation. A couple of suggestions on this end:
        a. The initial vignette about data download and QC could be moved to an appendix, since it's not very specific to the BASiCS model, and there is a lot of boilerplate code, e.g. converting gene symbols. Then we could start from a binary SingleCellExperiment object.
        b. The plotting code is quite verbose. It would be nice from a usability standpoint to have commonly-used plots included as part of the functionality of the package.
        c. Is there some way to provide better navigation among sections of the workflow (this may not be possible via F1000?)? This combined with a paragraph in the introduction ("This case study is organized as follows...section 3.1 describes downloading data from ArrayExpression, 3.2 annotates gene symbols, 3.3 examines QC,...") would make it easier for a reader to find the relevant section of the workflow.
        d. Or the version of this workflow that's at https://github.com/VallejosGroup/BASiCSWorkflow/ could be rendered and made available on Github, perhaps with some nice markdown features like code-folding and a floating TOC to make it easier to read.
         
    The comparison between the model estimates and the scran estimates in Figure 8 does help orient someone who is not completely familiar with the BASiCS model, but it would be nice to have a brief recap of the model in the Methods section (one or two equations), with interpretations, to explain the key parameters being estimated.  

### Minor comments:

    I encountered some issues regarding the formatting of the code, which the other reviewer also remarked upon. This may be limited to the html version of the article.
        a. newlines in `website` strings resulting in mal-formed URL.
        b. ^ rendered in some odd font that wouldn't execute when I copied a chunk into Rstudio.
        c. concentration.in..Mix.1.attomoles.ul was missing an `.`
         
    The built-in MCMC diagnostics are nice, but I do feel like Rhat (testing within vs between-chain variance, e.g. Vehtari et al., 20212) is maybe what I want most. Is there any provision for running parallel chains?
     
    It seemed that when I ran the `BASiCS_DetectHVG` function as specified, I got a couple of warning messages: "The posterior probability threshold chosen via EFDR calibration is too low. Probability threshold automatically set equal to 'ProbThresholdM'."
     
    Regarding differential expression testing, could the authors comment on the modeling assumptions about the two "populations" of cells? If I had biological replicates in some conditions (e.g. distinct mice, humans, or plots of stimulated cells), how would they be used here, or does the framework require assuming null inter-replicate variability?
     
    Figure 15: Caption says "log2 change in expression against against log mean expression for genes with higher residual over-dispersion in naive (A) cells and active (D) cells", but seems to refer to panels A and C. More broadly, it's not really clear what sort of conclusions we are supposed to draw from this sort of figure.

    Is the rationale for developing the new software tool clearly explained?

    Yes

    Is the description of the software tool technically sound?

    Yes

    Are sufficient details of the code, methods and analysis (if applicable) provided to allow replication of the software development and its use by others?

    Yes

    Is sufficient information provided to allow interpretation of the expected output datasets and any results generated using the tool?

    Partly

    Are the conclusions about the tool and its performance adequately supported by the findings presented in the article?

    Yes

### References
1. Crowell H, Soneson C, Germain P, Calini D, et al.: muscat detects subpopulation-specific state transitions from multi-sample multi-condition single-cell transcriptomics data. Nature Communications. 2020; 11 (1). Publisher Full Text
2. Vehtari A, Gelman A, Simpson D, Carpenter B, et al.: Rank-Normalization, Folding, and Localization: An Improved Rˆ for Assessing Convergence of MCMC (with Discussion). Bayesian Analysis. 2021; 16 (2). Publisher 
3. Full Text

### Competing Interests

No competing interests were disclosed.

### Reviewer Expertise

Bioinformatics, biostatistics, single-cell transcriptomics


# Review 3

## Michel S Naslavsky, Human Genome and Stem Cell Research Center, University of São Paulo, São Paulo, Brazil  

O'Callaghan and colleagues present an approach to analyze single-cell RNA sequencing data in a stepwise manner. This is very useful both to readers and to students engaged in learning applied bioinformatics. As a user (non-developer, non-expert in RNA analysis tool evaluation), my contribution will be from a different perspective from the other reviewers who made excellent and detailed comments on this manuscript.

1) Introduction, 2nd paragraph: “Moreover, these variability estimates can also be inflated by the technical noise that is typically observed in scRNA-seq data”

Comment: Please illustrate with examples of technical noise as presented above for extrinsic and intrinsic noise, e.g. RNA differential degradation, ligation bias, etc.

2) Introduction, 3rd paragraph: “However, despite the benefits associated to the use of spike-ins and UMIs, these are not available for all scRNA-seq protocols.”

Comment: Please provide a reason - something like “due to the very nature of the assay, which isolates library prep from external spike-ins and uses UMIs to map single-cell libraries…” or that spike-ins added to the library after pooling limit the full advantage of using them across single-cell populations.

3) Methods, 2nd paragraph: “Mean parameters μi quantify the overall expression for each gene i across the cell population under study.” 

Comment: Please define cell population as sample (all cells within a scRNA-seq assay) or post-processing UMAP, t-SNE, or similar clustering grouping. I understood the latter, but readers should be certain, and we need to understand which step these parameters refer to.

4) After Figure 5: “These thresholds can vary across datasets and should be informed by gene-specific QC metrics such as those shown in Figure 5 as well as prior knowledge about the cell types and conditions being studied, where available”.

Comment: I understand this is not the intent of this study, but if possible include some rationale behind thresholds for QCing gene exclusion based on types and conditions. Maybe bringing the choice for the example explored here.

5) After spike-in calculation step: “To update the sce_naive and sce_active objects, the user must create a data.frame whose first column contains the spike-in labels (e.g. ERCC-00130) and whose second column contains the number of molecules calculated above. We add this as row metadata for altExp (sce_naive) and altExp (sce_active).”

Comment: By ‘update’, do the authors mean ‘update after normalisation with spike-in’? If so, please specify.

7) MCMC diagnostics

Comment: I am by far not an expert on the analysis, but the authors were very successful in explaining the protocol in a stepwise manner. I would kindly ask if they can add the reason why this is needed: “to ensure that comparisons of gene expression are not random” or something in that direction. Readers will appreciate it.

8) Figures 15 and 16

Comment: These explanations are important to establish a convincing argument for using this workflow. Authors can explore further the ‘tight regulation’ versus ‘transcriptional burst’ or ‘sub-population structure’ scenarios with other examples (either from the literature or running an orthogonal analysis on larger scRNA-seq datasets of CD4+ T cells.

    Is the rationale for developing the new software tool clearly explained?

    Yes

    Is the description of the software tool technically sound?

    Yes

    Are sufficient details of the code, methods and analysis (if applicable) provided to allow replication of the software development and its use by others?

    Yes

    Is sufficient information provided to allow interpretation of the expected output datasets and any results generated using the tool?

    Yes

    Are the conclusions about the tool and its performance adequately supported by the findings presented in the article?

    Yes

### Competing Interests

No competing interests were disclosed.

### Reviewer Expertise

Population and medical genomics