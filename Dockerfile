FROM ubuntu:21.04
LABEL maintainer="Nacho Garcia <iggl@fhi.no>"
ENV PATH="/home/docker/Scripts:/home/docker/miniconda3/bin:${PATH}"
ARG PATH="/home/docker/Scripts:/home/docker/miniconda3/bin:${PATH}"
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    build-essential \
    g++ \
    cmake \
    wget \
    && useradd -ms /bin/bash docker

ARG USER=docker
ARG GROUP=docker
ARG UID
ARG GID

ENV USER=$USER
ENV GROUP=$GROUP
ENV UID=$UID
ENV GID=$GID
ENV HOME="/home/${USER}"

USER docker
RUN cd /home/docker \
    && wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    --no-check-certificate\
    && mkdir /home/docker/.conda \
    && mkdir /home/docker/Discovery \
    && mkdir /home/docker/Discovery/Fastq \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && conda create -y --quiet --override-channels \
     --channel iuc --channel bioconda \
     --channel r --channel defaults \
     --channel conda-forge \
     --name condaenv_discover \
     python=3.7 \
     perl=5.26.2 \
     perl-bioperl=1.7 \
     trimmomatic=0.39 \
     spades=3.15 \
     skesa=2.4 \
     muscle=3.8 \
     bowtie2=2.3.4 \
     samtools=1.3.1 \
     bcftools=1.3.1 \
     bwa=0.7.17 \
     mlst=2.16.1 \
     abricate=0.8.10 \
     emboss=6.6.0 \
     chewbbaca=2.7 \
     blast=2.11.0 \
     prodigal=2.6.3 \
     && conda update -n condaenv_discover --update-all
COPY Discovery/ /home/docker/Discovery/
USER root
RUN chown -R docker /home/docker/Discovery 
RUN cd /home/docker/Discovery/discover/scripts/fastq-pair-master \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make \
    && make install \
    && ln /home/docker/Discovery/discover/scripts/duk/duk /usr/local/bin/duk
USER docker
#RUN cd /home/docker/Discovery/discover/scripts/duk \
#    && make \
RUN  mv /home/docker/Discovery/discover/virulotyper /home/docker/miniconda3/envs/condaenv_discover/db
WORKDIR /home/docker/Discovery
ENTRYPOINT [ "/bin/bash","/home/docker/Discovery/discovery.sh"]