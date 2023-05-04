# For developers

!! WARNING !! This doc is for developers
to prepare example Docker images available on PennLINC Docker Hub.
Regular users should NOT edit this doc
and should not change the `Dockerfile` in this repo.
They should NOT
execute the commands in this doc either. 

The Docker image of example `Dockerfile` included in this repo
is publicly available on PennLINC Docker Hub:

https://hub.docker.com/r/pennlinc/docker_r

The tag names should be named as:
```
R<r_version>_vx.y.z
```

For example, `R4.1.2_v0.1`

## Prepare
```console
# 1. check if R version is consistent w/ that in Dockerfile;
# 2. increment the version number;
docker_tag="R4.1.2_v0.1"

docker build -t pennlinc/docker_r:${docker_tag} .

docker run --rm -it pennlinc/docker_r:${docker_tag} R

docker push pennlinc/docker_r:${docker_tag}
```

Then pull it as a Singularity image on cubic to test out.

Now, there are two more things to be done:
* Update [Releases.md](Releases.md): add this version + some descriptions of the changes
* Tag github repo with the version number, to make sure we also mark the `Dockerfile` with the corresponding tag version:

```
git tag -a ${docker_tag} -m "some messages"
git push origin ${docker_tag}
```

## Other tips
Other basic commands of `git tag`:

```
git tag     # list all the tags
git show <versionName>   # print the messages of the tag + commits
```
