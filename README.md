# BASiCSWorkflow

Bioconductor workflow to quantify and test changes in variability using BASiCS.
This workflows runs using the docker image 
[alanocallaghan/bocker](https://hub.docker.com/repository/docker/alanocallaghan/bocker).
To use the latest build of the docker
```bash
docker pull alanocallaghan/basicsworkflow2020-docker
```

To run the docker image via Rstudio server. The code below ensures that the files in 
/home/rstudio/mycode are available within the docker.

```bash
make server
```

> NOTE: for Macbook users with an M1 chip, the following WARNING will be returned:
> 
> ```WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested```
> 
> To avoid that a `--platform=linux/amd64` can be added:
> 
> ```bash
> docker run --platform=linux/amd64 -p 8787:8787 -v $(pwd):/home/rstudio/mycode -e PASSWORD=bioc alanocallaghan/basicsworkflow2020-docker
> ```
> 
> This issue has been documented by others e.g. [here](https://stackoverflow.com/questions/66662820/m1-docker-preview-and-keycloak-images-platform-linux-amd64-does-not-match-th)

Then access [http://localhost:8787](http://localhost:8787).
Username: rstudio, password = bioc.


Equivalently, to launch bash:
```bash
make run
```
