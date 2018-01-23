FROM container-registry.phenomenal-h2020.eu/phnmnl/speaq:dev_v1.2.4_cv0.1.8

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL software="rdolphin"
LABEL software.version="1.0"
LABEL version="0.1"
LABEL Description="rDolphin: Reliable automatic profiling of 1D 1H NMR Spectra, with additional tools for analysis"
LABEL website="https://github.com/danielcanueto/rDolphin"
LABEL documentation="https://github.com/danielcanueto/rDolphin"
LABEL license="https://github.com/phnmnl/container-rdolphin/blob/master/License.txt"
LABEL tags="Metabolomics"

# Install packages
RUN apt-get -y update && apt-get -y --no-install-recommends install ca-certificates wget zip unzip git libcurl4-gnutls-dev libcairo2-dev libxt-dev libxml2-dev libv8-dev libnlopt-dev libnlopt0 gdebi-core pandoc pandoc-citeproc software-properties-common make gcc gfortran g++ r-recommended r-cran-rcurl r-cran-foreach r-cran-multicore r-cran-base64enc r-cran-qtl r-cran-xml libgsl2 libgsl0-dev gsl-bin libssl-dev && \
    R -e "install.packages(c('minpack.lm','shinyjs','reshape2','data.table','plotly','shiny','DT','fields','baseline','apcluster','missRanger','ranger','heatmaply','ggplot2','caret','e1071','elasticnet','gridExtra','stringr','knitr','rmarkdown','devtools'), repos='https://mirrors.ebi.ac.uk/CRAN/')" && \
    R -e "devtools::install_github('danielcanueto/rDolphin')"

# Cleanup 
RUN apt-get -y --purge --auto-remove remove make gcc gfortran g++ && apt-get -y --purge remove libcurl4-gnutls-dev libcairo2-dev libxt-dev libxml2-dev libv8-dev libnlopt-dev && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /usr/src/rnmr1d /tmp/* /var/tmp/*

# Add scripts to container
#ADD scripts/* /usr/local/bin/
#RUN chmod +x /usr/local/bin/*

# Add testing to container
ADD runTest1.sh /usr/local/bin/runTest1.sh

