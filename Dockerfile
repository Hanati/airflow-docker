FROM ubuntu:18.04

ENV SLUGIFY_USES_TEXT_UNIDECODE=yes

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends apt-utils \
            curl \
            xz-utils \
            build-essential \
            libsqlite3-dev \
            libreadline-dev \
            libssl-dev \
            ca-certificates \
            openssl \
            wget \
            git \
            bzip2 \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/*

## miniconda3
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy

## link pip3 to pip
RUN ln -s /opt/conda/bin/pip /opt/conda/bin/pip3
ENV TINI_VERSION v0.16.1 
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini  
ENV PATH /opt/conda/bin:$PATH

## install depandencies
RUN pip3 install apache-airflow pymongo pywebhdfs

WORKDIR /home/airflow

ADD airflow.cfg /home/airflow/
ADD bootstrap.sh /etc/airflow/

EXPOSE 8080

CMD /etc/airflow/bootstrap.sh
