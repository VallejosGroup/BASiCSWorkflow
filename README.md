# BASiCSWorkflow
Bioconductor workflow to quantify and test changes in variability using BASiCS

To build the docker image, run:
```bash
docker build . -t bioconductor_docker_basics
```

To use with rstudio:
```bash
docker run -p 8787:8787 -v $(pwd):/home/rstudio/mycode -e PASSWORD=bioc bioconductor_docker_basics
```

Or to launch a shell:
```bash
docker run -v $(pwd):/home/rstudio/mycode -it bioconductor_docker_basics /bin/bash
```


