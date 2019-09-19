FROM jupyter/scipy-notebook:cf6258237ff9

USER root
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN mkdir /opt
COPY singularity /opt

RUN chown -R ${NB_UID} ${HOME}


USER ${NB_USER}
