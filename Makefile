.PHONY: Workflow

Workflow.pdf: Workflow.Rmd
	r -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'
