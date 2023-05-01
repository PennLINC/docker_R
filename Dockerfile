
# Building Docker file for using R packages on CUBIC
# When update this Dockerfile, please update tag of pre-built docker image `audreycluo/r-packages-for-cubic:<tag>`
 
 
# Base image: using pre-built docker image
FROM rocker/verse:4.1.2
 
# install hdf5r
RUN apt-get update && apt-get install -y --no-install-recommends \
    libhdf5-dev \
    texlive-fonts-recommended

# install R packages from CRAN:
RUN install2.r --error --ncpus -4 \
	broom \
	cifti \
	cowplot \
	EnvStats \
	doParallel \
	dplyr \
	gamlss \
	glue \
	ggplot2 \
	ggpubr \
	gratia \
	hdf5r \
	janitor \
	magrittr \
	MASS \
    	matrixStats \
	mgcv \
	pammtools \
	pbmcapply \
	pbapply \
	purrr \
	raveio \
	reshape \
	reshape2 \
	rlang \
	R.matlab \
	stargazer \
	stats \
	stringr \
	tibble \
	tidyr \
	tidyverse

 

# install from GitHub: covbat
RUN R -e 'devtools::install_github("andy1764/CovBat_Harmonization/R")'

# install from Github: covbat-GAM  
RUN R -e 'devtools::install_github("andy1764/ComBatFamily")'

 