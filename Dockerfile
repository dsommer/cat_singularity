FROM jupyter/scipy-notebook:cf6258237ff9

USER root

RUN cp /home/$NB_USER/singularity /usr/local/bin/. && chown root:root /usr/local/bin/singularity && chmod 755 /usr/local/bin/singularity
    
USER $NB_UID

    




