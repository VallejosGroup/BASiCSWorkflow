.PHONY: run server

all: Workflow.pdf Supplements.pdf

IMAGE=alanocallaghan/bocker:0.2.0

%.pdf: %.Rmd
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		$(IMAGE) \
		/bin/bash \
		-c 'Rscript -e "rmarkdown::render(\"$<\")"'


run:
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
		-u rstudio \
		-it $(IMAGE) \
		/bin/bash

server:
	docker run -p 8787:8787 -v $(shell pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/bocker:0.1.0

#	r -e 'rmarkdown::render("Workflow.Rmd", output_format="all")'
