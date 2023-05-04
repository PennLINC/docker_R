# For developers

⚠️ ⚠️ WARNING ⚠️ ⚠️
This doc is for developers
to prepare example Docker images available on PennLINC Docker Hub.
Regular users should NOT edit this doc
and should not change the `Dockerfile` in this Github repo.
They should NOT
execute the commands in this doc either. 

The Docker image of example `Dockerfile` included in this repo
is publicly available on PennLINC Docker Hub:

https://hub.docker.com/r/pennlinc/docker_r

The tag names should be named as:
```
R<r_version>_vx.y.z    # `.z` can be optional
```

For example, `R4.1.2_v0.1`

## Build Docker image based on example `Dockerfile` and make a release

```console
# 1. check if R version is consistent w/ that in Dockerfile;
# 2. check the version tag on Docker Hub or on GitHub Releases page; then increment the version number;
docker_tag="R?????_v?????"    # e.g., "R4.1.2_v0.1"

docker build -t pennlinc/docker_r:${docker_tag} .

docker run --rm -it pennlinc/docker_r:${docker_tag} R

docker push pennlinc/docker_r:${docker_tag}
```

Then pull it as a Singularity image on cubic to test out.

Now, there are two more things to be done:
1. Tag github repo with the version number, to make sure we also mark the `Dockerfile` with the corresponding tag version:

```
git tag -a ${docker_tag} -m "some messages"
git push origin ${docker_tag}
```

2. Make a release announcement on [Releases page](https://github.com/PennLINC/docker_R/releases):
This is to clearly mark the changes + what were changed.

* go to front page of the github, click "create a new release" under "Releases" in right panels
* "choose a tag": choose the tag you just made
* Title of the release: can also put this tag number
* Finally, add some descriptions of the changes you made in the `Dockerfile` etc.

## Other tips
Other basic commands of `git tag`:

```
git tag     # list all the tags
git show <versionName>   # print the messages of the tag + commits
```
