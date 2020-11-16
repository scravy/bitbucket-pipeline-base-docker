FROM atlassian/default-image:2

RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    aws --version

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -qq \
        python3 \
        python3-pip

