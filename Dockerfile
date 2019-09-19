FROM jupyter/scipy-notebook:cf6258237ff9

USER root
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}

COPY singularity /opt/singularity
RUN chmod 4775 /opt/singularity/libexec/singularity/bin/starter-suid
RUN chown -R ${NB_UID} ${HOME}

RUN adduser ${NB_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${NB_USER}
