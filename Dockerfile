FROM jupyter/scipy-notebook:cf6258237ff9

USER root

RUN wget -O - http://neuro.debian.net/lists/xenial.us-ca.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    apt-get update &&  apt-get install -y singularity-container
    
USER $NB_UID

    




