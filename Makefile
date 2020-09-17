.PHONY: run server

all:
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		alanocallaghan/bocker \
		/bin/bash \
		-c "make Workflow.pdf && make Supplements.pdf"

%.pdf: %.Rmd
	Rscript -e 'rmarkdown::render("$<", output_format="all")'

run:
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
		-u rstudio \
		-it alanocallaghan/bocker \
		/bin/bash

server:
	docker run -p 8787:8787 -v $(shell pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/bocker

#	r -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'
