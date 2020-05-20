.PHONY: Workflow run server

Workflow.pdf: Workflow.Rmd
	docker run -v $(shell pwd):/home/rstudio/mycode -w /home/rstudio/mycode alanocallaghan/bocker /bin/bash -c make workflow

Supplements.pdf: Supplements.Rmd
	docker run -v $(shell pwd):/home/rstudio/mycode -w /home/rstudio/mycode alanocallaghan/bocker /bin/bash -c 

workflow: Workflow.Rmd
	Rscript -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'

supplements: Supplements.Rmd
	Rscript -e 'rmarkdown::render("Supplements.Rmd", clean = FALSE)'

run:
	docker run -v $(shell pwd):/home/rstudio/mycode -w /home/rstudio/mycode -it alanocallaghan/bocker /bin/bash

server:
	docker run -p 8787:8787 -v $(shell pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/bocker

#	r -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'
