# BASiCSWorkflow

Bioconductor workflow to quantify and test changes in variability using BASiCS

To build the docker image, run:
```bash
docker build . -t bioconductor_docker_basics
```

To run the docker image via Rstudio server. The code below ensures that the 
files in /home/rstudio/mycode are available within the docker.

```bash
docker run -p 8787:8787 -v $(pwd):/home/rstudio/mycode -e PASSWORD=bioc bioconductor_docker_basics
```

Then access [http://localhost:8787](http://localhost:8787).
Username: rstudio, password = bioc.
