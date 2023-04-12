# docker_R
This holds example `Dockerfile` for building a Docker image that includes R packages.

## How to directly use the Docker image built based on this example `Dockerfile`?
Please refer to the below section for [how to use as Singularity container on clusters](#step-5.-use-as-singularity-container-on-clusters).

## How to reuse this `Dockerfile` for my case?
Different projects may require different R packages. If the list of R packages included in this example `Dockerfile`
does not fit your purpose, e.g., you hope to add more, you can make a new `Dockerfile` and build your own Docker image!

### Step 1. Preparations
* Make sure you have a [Docker Hub](https://hub.docker.com/) account - it's free!
* Make sure you've installed Docker on your labtop
  * On Mac, make sure Docker App is *running*
* Set up your docker account locally:
  * TODO: add instructions here

!! warning !! 
* You cannot use cubic or any cluster to build docker image!
* It's better to use Linux system computer or Mac with Intel chip (instead of M1 or M2 chip)
  * Mac with M1/M2 chip has different architecture lol. Talk to informatics team for how to proceed.
  
### Step 2. Write `Dockerfile`
You have two options - just choose one of them:
#### Way 1: Start from this example one:
In other words, you'll use this example Docker image as a base image. This will make building step faster.
Your `Dockerfile` will look like this:

```
FROM audreycluo/r-packages-for-cubic:<tag>

# below: install additional R packages you'd like
```

#### Way 2: Start from scratch:
Just copy example `Dockerfile` from this github repository. Modify it or add more commands for your purpose.

### Step 3. Build Docker image
TODO: add instructions here

### Step 4. Push to your Docker Hub repository
TODO: add instructions here

### Step 5. Use as Singularity container on clusters
TODO: add instructions here

## Debugging
Some R packages require installing some necessary libraries in the Docker image system (e.g., `libhdf5-dev`)
before you can properly install the R packages. Check the manual of the R packages you want to install if you run into issues
using them.

