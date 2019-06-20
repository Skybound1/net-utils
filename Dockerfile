FROM debian:stretch-slim

# Useful networking things
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl \
        dnsutils \
        iproute2 \
        iputils-ping \
        jq \
        net-tools \
        netcat-traditional \
        nmap \
        openssh-client \
        socat \
        tcpdump \
        traceroute \
        vim \
        && \
    rm -rf /var/lib/apt/lists/*

# Adds docker client if in a swarm
RUN curl https://download.docker.com/linux/static/stable/x86_64/$(curl -s https://download.docker.com/linux/static/stable/x86_64/ | grep "href=\"docker" | cut -d \" -f 2 | tail -n1) | tar -xz -C /tmp/ && \
    mv /tmp/docker/docker /usr/local/bin && \
    rm -rf /tmp/*

# Adds kubectl if in a kube cluster
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl

# Adds testssl.sh for ssl scanning
RUN curl -L http://testssl.sh -o testssl.sh && \
   mv testssl.sh /usr/local/bin/testssl && \
   chmod +x /usr/local/bin/testssl
