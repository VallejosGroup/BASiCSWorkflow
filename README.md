# BASiCSWorkflow

Bioconductor workflow to quantify and test changes in variability using BASiCS.
This workflows runs using the docker image 
[alanocallaghan/bocker](https://hub.docker.com/repository/docker/alanocallaghan/bocker).
To use the latest build of the docker
```bash
docker pull alanocallaghan/bocker
```

To run the docker image via Rstudio server. The code below ensures that the files in 
/home/rstudio/mycode are available within the docker.

```bash
docker run -p 8787:8787 -v $(pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/bocker
```

Then access [http://localhost:8787](http://localhost:8787).
Username: rstudio, password = bioc.


Equivalently, to launch bash:
```bash
docker run -v $(pwd):/home/rstudio/mycode -it alanocallaghan/bocker /bin/bash
```
