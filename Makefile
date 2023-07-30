.PHONY: run server

all: Workflow.pdf

IMAGE=alanocallaghan/basicsworkflow2020-docker
VERSION=0.4.0

%.pdf: %.Rmd
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		$(IMAGE):$(VERSION) \
		/bin/bash \
		-c 'Rscript -e "rmarkdown::render(\"$<\")"'

run:
	docker run -v $(shell pwd):/home/rstudio/mycode \
		-w /home/rstudio/mycode \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
		-u $(id -u):$(id -g) \
		-it $(IMAGE):$(VERSION) \
		/bin/bash

server:
	docker run -p 8787:8787 -v $(shell pwd):/home/rstudio/mycode -e PASSWORD=bioc $(IMAGE):$(VERSION)
