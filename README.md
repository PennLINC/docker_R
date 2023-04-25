# docker_R
This repo holds an example `Dockerfile` for building a Docker image that includes R packages.

## How to directly use the Docker image built based on our example `Dockerfile`:
Please refer to the below section for [how to use as Singularity container on clusters](#step-5.-use-as-singularity-container-on-clusters).

## How to reuse this `Dockerfile` for your own purposes:
Different projects may require different R packages. If the list of R packages included in this example `Dockerfile`
does not fit your purposes, e.g., you hope to add more, you can make a new `Dockerfile` and build your own Docker image!
If you do build upon the example Dockerfile, remember to update the version. 

Other formatting tips include:
* removing spaces at the end of each line of your Dockerfile
* making sure that there aren't comments at the end of each line. Comments should be separate lines from commands. 

### Step 1. Prep
a. Make a [Docker Hub](https://hub.docker.com/) account if you don't have one - it's free!  
b. Install [Docker](https://docs.docker.com/get-docker/) on your laptop. On Mac, make sure Docker App is *running*!  
c. Log into your Docker account on the Docker App locally 
    
!! warning !! 
* You cannot use cubic or any cluster to build docker image!
* It's better to use Linux system computer or Mac with Intel chip (instead of M1 or M2 chip)
  * Mac with M1/M2 chip has different architecture lol. Talk to informatics team for how to proceed.
  
### Step 2. Write `Dockerfile`
You have two options - just choose one of them:
#### Way 1: Build on this example Dockerfile:
In other words, you'll use this example Docker image as a base image. This will make Step 3 (`docker build`) faster. You can find the most updated version of the example Docker image and its corresponding tag [HERE](https://hub.docker.com/repository/docker/audreycluo/r-packages-for-cubic/general).  

Your `Dockerfile` should look something like this:

```
FROM audreycluo/r-packages-for-cubic:<tag>

# install additional R packages 
RUN install2.r --error --ncpus -4 \
    <package1> \
    <package2> \
    ...
```

#### Way 2: Start from scratch:
Just copy the example `Dockerfile` from this github repository. Modify it or add more commands for your purposes.

### Step 3. Build Docker image
a. If you're using a Mac, first enter `export DOCKER_BUILDKIT=0` and `export COMPOSE_DOCKER_CLI_BUILD=0` into the Mac bash terminal before running `docker build` below.  
b. To build your Docker image, you need to run the following command:
 
```
$ docker build -t <docker_username>/<docker_repo>:${docker_tag} .
```

For example:
```
$ docker build -t <docker_username>/r-packages-for-cubic:0.0.1 .
```

Important formatting tips include:
* Remember the trailing period!! And remove any spaces after the period!
* An example `docker_tag` could be `0.0.1`
* The Dockerfile should be in the same folder as current working directory that your terminal is using

### Step 4. Push to your Docker Hub repository
 
```
$ docker push "<docker_username>/<docker_repo>:${docker_tag}"
```

### Step 5. Run a test locally (optional, but recommended)
 
```
$ docker run --rm -it <docker_username>/<docker_repo>:${docker_tag} R
```
### Step 6. Use as Singularity container on clusters
* If you don't already have a `software` directory in your project directory, we suggest you make one. Then create a `docker` sub-folder.
* Pull the Docker image onto cluster:
 
```
$ singularity pull docker://<docker_username>/<docker_repo>:${docker_tag}
```
After a while, you should have a .sif file in your directory. 

To run docker on a cluster, use the following commands:
 
General format:
```
singularity run --cleanenv \
    <docker_repo>_<docker_tag>.sif \
    <command_you_want_to_run>
```

Example:
```
singularity run --cleanenv \
   /cbica/projects/<project_name>/software/docker/<docker_repo>_<docker_tag>.sif \
    R
```
You can put the above commands for `singularity run` in a bash file and submit the bash file as a job.

## Debugging
Some R packages require installing some necessary libraries in the Docker image system (e.g., `libhdf5-dev`)
before you can properly install the R packages. Check the manual of the R packages you want to install if you run into issues
using them.

