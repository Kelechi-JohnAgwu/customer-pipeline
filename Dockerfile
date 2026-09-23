FROM rocker/r-ver

WORKDIR /project

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

COPY renv.lock renv.lock

RUN R -e "renv::restore()"

COPY R/pipeline.R .

CMD ["Rscript", "pipeline.R"]