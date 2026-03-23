FROM ubuntu:24.04
ENV TARGETARCH="linux-x64"

# Run the agent as root.
ENV AGENT_ALLOW_RUNASROOT="true"

RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    libicu74 \
    unzip \
    ca-certificates \
    gnupg \
    lsb-release \
    docker.io \
    openjdk-17-jdk \
    maven \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin \
    && curl -L https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 -o /usr/local/bin/cosign \
    && chmod +x /usr/local/bin/cosign \
    && rm -rf /var/lib/apt/lists/*

# 1. Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 2. Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent

ENTRYPOINT [ "./start.sh" ]
