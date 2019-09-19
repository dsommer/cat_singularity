FROM jupyter/scipy-notebook:cf6258237ff9

USER root
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
COPY singularity /opt/.
RUN chmod 4775 /opt/singularity/libexec/singularity/bin/starter-suid
RUN chown -R ${NB_UID} ${HOME}


USER ${NB_USER}
