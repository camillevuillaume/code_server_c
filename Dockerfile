FROM lscr.io/linuxserver/code-server:latest

# Install system packages for C/C++ development including GDB and Google Test
RUN apt-get update && \
    apt-get install -y gcc make cmake clangd gdb libgtest-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install python
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/porkbun

FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
