FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y \
        curl \
        dnsutils \
        iputils-ping \
        jq \
        net-tools \
        netcat-traditional \
        nmap \
        socat \
        tcpdump \
        traceroute \
        vim \
        && \
    rm -rf /var/lib/apt/lists/*
