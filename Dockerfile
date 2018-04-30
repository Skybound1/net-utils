FROM debian:jessie

RUN apt-get update && \
    apt-get install -y \
        curl \
        dnsutils \
        jq \
        net-tools \
        netcat-openbsd \
        nmap \
        socat \
        tcpdump \
        traceroute \
        && \
    rm -rf /var/lib/apt/lists/*
