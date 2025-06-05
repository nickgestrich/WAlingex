# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.4.2

# required
MAINTAINER Nikolas Gestrich <gestrich@uni-frankfurt.de>

COPY . /WAlingex

# go into the repo directory
RUN . /etc/environment \
  # Install linux depedendencies here
  # e.g. need this for ggforce::geom_sina
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \
  # build this compendium package
  && R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
  && R -e "remotes::install_github(c('rstudio/renv', 'quarto-dev/quarto-r'))" \
  # install pkgs we need
  && R -e "renv::restore()"
