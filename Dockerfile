FROM jupyter/scipy-notebook:1386e2046833

USER root
RUN apt-get update && apt-get install -y squashfs-tools


# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}

COPY singularity /opt/singularity
RUN chmod 4775 /opt/singularity/libexec/singularity/bin/starter-suid
RUN chown -R ${NB_UID} ${HOME}

RUN adduser ${NB_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${NB_USER}
