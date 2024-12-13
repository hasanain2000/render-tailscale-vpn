FROM debian:bullseye-slim

# Setup Tailscale and Python (for the health check)
WORKDIR /tailscale.d
COPY start.sh /tailscale.d/start.sh

ENV TAILSCALE_VERSION "latest"
ENV TAILSCALE_HOSTNAME "render-app"
ENV TAILSCALE_ADDITIONAL_ARGS ""

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    wget \
    iptables \
    sudo \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

RUN chmod +x ./start.sh

EXPOSE 80

CMD ["./start.sh"]
