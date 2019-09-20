#FROM jupyter/scipy-notebook:1386e2046833
FROM jupyter/minimal-notebook:1386e2046833
USER root
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

# install singularity
RUN adduser ${NB_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN apt-get update && apt-get install -y \
    uidmap \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup-bin
    
RUN export VERSION=1.12 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

USER ${NB_USER}

RUN echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
ENV GOPATH=${HOME}/go
ENV PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin
RUN export VERSION=3.4.0 && \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    rm singularity-${VERSION}.tar.gz
    
WORKDIR singularity
RUN ./mconfig && \
    make -C ./builddir
USER root
RUN make -C ./builddir install
USER ${NB_USER}
WORKDIR ${HOME}

