#FROM jupyter/scipy-notebook:1386e2046833
FROM jupyter/minimal-notebook:1386e2046833
USER root
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

# install singularity
RUN adduser ${NB_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN apt-get update && apt-get install -y squashfs-tools libssl-dev uuid-dev
RUN export VERSION=1.12 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

#COPY singularity /opt/singularity
#RUN chmod 4775 /opt/singularity/libexec/singularity/bin/starter-suid

USER ${NB_USER}
RUN echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    source ~/.bashrc
RUN export VERSION=3.3.0 && # adjust this as necessary \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    cd singularity && \
    ./mconfig && \
    make -C ./builddir && \
    sudo make -C ./builddir install
