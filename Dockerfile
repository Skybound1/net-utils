FROM clux/muslrust:stable as freezer


RUN git clone https://github.com/WithSecureLabs/freezer.git && \
    cd freezer && \
    cargo build --target x86_64-unknown-linux-musl --release && \
    cp target/x86_64-unknown-linux-musl/release/freezer /

FROM debian:stable-slim

# Useful networking things
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        arp-scan \
        awscli \
        curl \
        dnsutils \
        dsniff \
        iproute2 \
        iputils-ping \
        jq \
        less \
        net-tools \
        netcat-traditional \
        nmap \
        openssh-client \
        procps \
        socat \
        tcpdump \
        traceroute \
        vim \
        && \
    rm -rf /var/lib/apt/lists/*

# Adds docker client if in a swarm
RUN curl https://download.docker.com/linux/static/stable/x86_64/$(curl -s https://download.docker.com/linux/static/stable/x86_64/ | grep "href=\"docker" | cut -d \" -f 2 | grep -v rootless | tail -n1) | tar -xz -C /tmp/ && \
    mv /tmp/docker/docker /usr/local/bin && \
    rm -rf /tmp/*

# Adds kubectl if in a kube cluster
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl

# Sets SUID binary
RUN chmod +s /bin/dash

# Adds amicontained
RUN curl -fSL https://github.com/genuinetools/amicontained/releases/download/v0.4.7/amicontained-linux-amd64 -o /usr/local/bin/amicontained && \
    chmod +x /usr/local/bin/amicontained

# Adds reg
RUN curl -fSL https://github.com/genuinetools/reg/releases/download/v0.16.0/reg-linux-amd64 -o /usr/local/bin/reg && \
    chmod +x /usr/local/bin/reg

# Adds freezer
COPY --from=freezer /freezer /usr/local/bin/freezer
