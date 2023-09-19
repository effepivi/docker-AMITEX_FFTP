# Download base image ubuntu 22.04
FROM ubuntu:22.04


# Switch to root to install packages
USER root

# Update Ubuntu Software repository
RUN apt update
RUN apt upgrade -y

RUN apt-get install -y \ 
    gfortran \
    gcc \
    g++ \
    make \
    cmake \
    fftw3 \
    fftw3-dev \
    libopenmpi-dev \
    openmpi-bin \
    wget \
    vim \
    git

ENV FFT_inc=/usr/include
ENV FFT_lib=/usr/lib/x86_64-linux-gnu

# Go to /usr/local
WORKDIR /usr/local/src

# Download TFEL
RUN wget --quiet https://master.dl.sourceforge.net/project/tfel/TFEL-4.1.0/Version%204.10.tar.gz

# Download AMITEX
RUN wget --quiet http://www.maisondelasimulation.fr/projects/amitex/general/_build/html/_static/_download/amitex_fftp-v8.17.13.tar

# Extract TFEL
RUN tar zxfp "Version 4.10.tar.gz"

# Extract AMITEX
RUN tar xfp amitex_fftp-v8.17.13.tar

# Build AMITEX
WORKDIR /usr/local/src/amitex_fftp-v8.17.13/
#RUN git checkout install
#RUN git pull
RUN sed -i "/^#FC\=/c\FC=gfortran" install
RUN ./install

# Build TFEL
WORKDIR /usr/local/src/thelfer-tfel-a4815e5
RUN mkdir bin
WORKDIR /usr/local/src/thelfer-tfel-a4815e5/bin
RUN cmake ..
RUN make -j16
RUN make install


# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan

# Make sure jovyan has ownership of Amitex's directory
RUN chown -R jovyan:jovyan /usr/local/src/amitex_fftp-v8.17.13/

# Swith user
USER jovyan

# Go to test directory
WORKDIR /usr/local/src/amitex_fftp-v8.17.13/validation

CMD ["/bin/bash"]
