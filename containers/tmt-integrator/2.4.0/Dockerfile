FROM ubuntu:18.04

# MAINTAINER Felipe da Veiga Leprevost <felipevl@umich.edu>

# Set noninterative mode
ENV DEBIAN_FRONTEND noninteractive

# apt update and install global requirements
RUN apt-get clean all &&  \
    apt-get update &&     \
    apt-get upgrade -y && \
    apt-get install -y    \
    openjdk-8-jre


# create shared folders
RUN mkdir /data

# Add $HOME/bin to path
ENV PATH=$PATH:/data

# Share default volumes
VOLUME ["/data", "/config"]

# Overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]

# change workdir
WORKDIR /data

ADD https://github.com/Nesvilab/TMT-Integrator/releases/download/2.4.0/TMTIntegrator_v2.4.0.jar /data
ADD https://github.com/Nesvilab/TMT-Integrator/releases/download/2.4.0/tmt-i_param_v2.4.0.yml /data

ENV PATH /data/:$PATH
