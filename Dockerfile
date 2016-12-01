## Start with the hadleyverse image from Rocker, then add population
## genetics images on top.

FROM rocker/tidyverse:latest
MAINTAINER David L Gibbs dgibbs@systemsbiology.org

## Install any packages from CRAN
RUN rm -rf /tmp/*.rds \
&&  install2.r --error \
    lme4 \
    multcomp \
    mgcv \
    randomForest \
    glmnet \
    parallel \
    Rcpp \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Bioconductor base
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite();'

## Bioconductor packages (they may be dependencies)
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("qvalue");'

## Install my own package from Github
RUN installGithub.r \
    gibbsdavidl/CatterPlots \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds
