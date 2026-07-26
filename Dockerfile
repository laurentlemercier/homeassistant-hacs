# syntax=docker/dockerfile:1.7

ARG HACS_VERSION=latest

###############################################################################
# Builder
###############################################################################

FROM alpine:3.22 AS builder

ARG HACS_VERSION

RUN apk add --no-cache \
        curl \
        unzip \
        ca-certificates

WORKDIR /build

RUN mkdir hacs

RUN if [ "$HACS_VERSION" = "latest" ]; then \
        URL="https://github.com/hacs/integration/releases/latest/download/hacs.zip"; \
    else \
        URL="https://github.com/hacs/integration/releases/download/${HACS_VERSION}/hacs.zip"; \
    fi && \
    curl -fsSL "$URL" -o hacs.zip && \
    unzip hacs.zip -d hacs && \
    rm hacs.zip

###############################################################################
# Runtime
###############################################################################

FROM alpine:3.22

LABEL org.opencontainers.image.title="Home Assistant HACS Init"
LABEL org.opencontainers.image.description="Initialise HACS inside Home Assistant config"
LABEL org.opencontainers.image.vendor="Laurent Lemercier"

RUN apk add --no-cache \
        bash \
        ca-certificates

COPY --from=builder /build/hacs /opt/hacs

COPY init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]