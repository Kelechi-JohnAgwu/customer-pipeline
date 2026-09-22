FROM rocker/r-ver

WORKDIR /project

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('dplyr', 'DBI', 'RPostgres', 'paws.storage'), repos='https://cloud.r-project.org')"

RUN R -e "stopifnot(requireNamespace('paws.storage', quietly = TRUE))"

COPY R/pipeline.R .

CMD ["Rscript", "pipeline.R"]