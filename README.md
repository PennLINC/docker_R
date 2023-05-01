# docker_R
This repo holds an example `Dockerfile` for building a Docker image that includes R packages.

## How to directly use the Docker image built based on our example `Dockerfile`:
Please refer to the below section for [how to use as Singularity container on clusters](#step-6-use-as-singularity-container-on-clusters).

## How to reuse this `Dockerfile` for your own purposes:
Different projects may require different R packages. If the list of R packages included in this example `Dockerfile`
does not fit your purposes, e.g., you hope to add more, you can make a new `Dockerfile` and build your own Docker image!
When doing so, make sure you push the built Docker image to **your own** Docker Hub account (we'll cover how to do this below)
TODO: move this to later step: "remember to update the version. "

Other formatting tips include:
* removing spaces at the end of each line of your Dockerfile
* making sure that there aren't comments at the end of each line. Comments should be separate lines from commands. 

### Step 1. Prep
a. Make a [Docker Hub](https://hub.docker.com/) account if you don't have one - it's free!  
b. Make a new repository under your Docker Hub account. Remember the name - we'll use it later.
c. Install [Docker](https://docs.docker.com/get-docker/) on your laptop. On Mac, make sure Docker Desktop App is *running*! I.e., You should see a static icon of Docker in your computer's menu bar.
d. Log into your Docker account on the Docker App locally 

    
!! warning !! 
* You cannot use cubic or any cluster to build docker image!
* It's better to use Linux system computer or Mac with Intel chip (instead of M1 or M2 chip)
  * Mac with M1/M2 chip has different architecture lol. Talk to informatics team for how to proceed.
  
### Step 2. Write `Dockerfile`
You have two options - just choose one of them:
#### Way 1: Build upon this example Dockerfile:
In other words, you'll use this example Docker image (`audreycluo/r-packages-for-cubic`) as a base image, and add additional R packages you'd like. This will make Step 3 (`docker build`) faster.

You still need to write a `Dockerfile`. Different from the example `Dockerfile`, your `Dockerfile` should look something like this:

```
FROM audreycluo/r-packages-for-cubic:<tag>

# install additional R packages 
RUN install2.r --error --ncpus -4 \
    <package1> \
    <package2> \
    ...
```

Here, first you need to find out the tag version of `audreycluo/r-packages-for-cubic`'s Docker image you want to use as a base image. You can find the most updated version of the example Docker image and its corresponding tag [HERE](https://hub.docker.com/r/audreycluo/r-packages-for-cubic/tags). Then please replace `<tag>` in line #1 with that tag string.

#### Way 2: Build a Docker image from scratch:
Just copy the example `Dockerfile` from this github repository. Modify it or add more commands for your purposes.

!!warning!! Do not overwrite the example `Dockerfile` in this github repository and push it back to github! Best keep your own `Dockerfile` somewhere else.

### Step 3. Build Docker image
By following `Step `2, you should have a new `Dockerfile` ready for building a Docker image.

a. If you're using a Mac, first enter `export DOCKER_BUILDKIT=0` and `export COMPOSE_DOCKER_CLI_BUILD=0` into the Mac bash terminal before running `docker build` below.  
b. To build your Docker image, you need to run the following command:
 
```
$ docker build -t <docker_username>/<docker_repo>:${docker_tag} .
```

For example:
```
$ docker build -t <docker_username>/r-packages-for-cubic:0.0.1 .
```

Important notes and tips include:
* `<docker_username>` is your personal Docker Hub's user name.
* `<docker_repo>` is the name of your Docker Hub repository where the Docker image will be. You should have created it in `Step 1`. If not, please create one on Docker Hub now.
* Remember the trailing period!! And remove any spaces after the period!
* An example `docker_tag` could be `0.0.1`
    * If you modify your `Dockerfile` in the future and want to make an updated Docker image, please make sure you increment the version tag number too! e.g., `0.0.2`, `0.0.3`, ... `0.1.0`, ... `1.0.0`, etc
* The Dockerfile should be in the same folder as current working directory that your terminal is using

### Step 4. Run a test locally (optional, but highly recommended)
 
```
$ docker run --rm -it <docker_username>/<docker_repo>:${docker_tag} R
```

### Step 5. Push to your Docker Hub repository
 
```
$ docker push <docker_username>/<docker_repo>:${docker_tag}
```

### Step 6. Use as Singularity container on clusters
On clusters, usually there is no Docker installed. Instead, we will pull the Docker image as a Singularity image.

* If you don't already have a `software` directory in your cluster's project directory, we suggest you make one. Then create a `containers` sub-folder.
* Pull the Docker image onto cluster:
 
```
$ singularity pull docker://<docker_username>/<docker_repo>:${docker_tag}
```

<details>
<summary>If you want to directly use the Docker image that's built by the example `Dockerfile` in this GitHub repoistory:</summary>
<br>

You should run this command:

```
$ singularity pull docker://audreycluo/r-packages-for-cubic:${docker_tag}
```

This prebuilt image is located at: https://hub.docker.com/r/audreycluo/r-packages-for-cubic. Find the latest tag name and replace `${docker_tag}` in above command with it.

!! warning !! You can pull Docker images from this Docker Hub repository, but **do NOT push** to it!!! - this is Audrey's personal account!
</details>

<br>
After a while, you should have a `.sif` file in your directory. This is the Singularity image that was built based on your Docker image.

To run the Singularity image, use the following commands:
 
General format:
```
singularity run --cleanenv \
    -B /directory/of/your/data,/directory/of/your/R_scripts \
    /path/to/software/containers/<docker_repo>_<docker_tag>.sif \
    <command_you_want_to_run>
```

Example:
```
singularity run --cleanenv \
    -B /directory/of/your/data,/directory/of/your/R_scripts \
    /cbica/projects/<project_name>/software/containers/<docker_repo>_<docker_tag>.sif \
    R
```

Notes and tips:
* Here, `-B /directory/of/your/data,/directory/of/your/R_scripts` allows you to mount the data and scripts directory so that singularity can read and write data inside it. If your data exists inside your current working directory, you might do -B $PWD;
    * To only bind one directory, use `-B /directory/you/want/to/bind`
    * Note: you might skip this `-B` argument if you're using PennMed CUBIC clusters - directories of your project account have been automatically bound.
* You can put the above command of `singularity run` in a bash file and submit the bash file as a job.

## Debugging
Some R packages require installing some necessary libraries in the Docker image system (e.g., `libhdf5-dev`)
before you can properly install the R packages. Check the manual of the R packages you want to install if you run into issues
using them.

