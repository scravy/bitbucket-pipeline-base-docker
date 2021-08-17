FROM debian:bullseye-slim

# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Install base dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq install \
        software-properties-common \
        build-essential \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        jq \
        ssh-client \
        zip \
        unzip \
        iputils-ping \
        python3 \
        python3-pip \
        python3-dev \
    && pip3 install --no-cache-dir \
        pyyaml \
        jinsi \
        boto3 \
        docker-compose \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq purge \
        build-essential \
        python3-pip \
        python3-dev \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq autoremove --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# eksctl
RUN bash -c 'curl -s -L0 "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp' \
    && mv /tmp/eksctl /usr/local/bin \
    && eksctl version

# kubectl
RUN bash -c 'curl -s -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"' \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && kubectl version --client


# Atlassian Bitbucket specifics below

# Create dirs and users
RUN mkdir -p /opt/atlassian/bitbucketci/agent/build \
    && sed -i '/[ -z \"PS1\" ] && return/a\\ncase $- in\n*i*) ;;\n*) return;;\nesac' /root/.bashrc \
    && useradd --create-home --shell /bin/bash --uid 1000 pipelines

WORKDIR /opt/atlassian/bitbucketci/agent/build

ENTRYPOINT /bin/bash

