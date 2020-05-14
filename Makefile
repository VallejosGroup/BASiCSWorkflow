.PHONY: Workflow run server

Workflow.pdf: Workflow.Rmd
	docker run -v $(shell pwd):/home/rstudio/mycode -w /home/rstudio/mycode alanocallaghan/bocker /bin/bash -c "r -e 'rmarkdown::render(\"Workflow.Rmd\", output_format=\"all\")'"

run:
	docker run -v $(shell pwd):/home/rstudio/mycode -w /home/rstudio/mycode -it alanocallaghan/bocker /bin/bash

server:
	docker run -p 8787:8787 -v $(shell pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/bocker

#	r -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'
