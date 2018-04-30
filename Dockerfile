FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y \
        curl \
        dnsutils \
        jq \
        net-tools \
        netcat-traditional \
        nmap \
        socat \
        tcpdump \
        traceroute \
        && \
    rm -rf /var/lib/apt/lists/*
