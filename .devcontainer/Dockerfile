ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION}

ARG TARGETARCH
ARG LUAU_LSP_VERSION
ARG LUAU_LSP_SHA256_AMD64
ARG LUAU_LSP_SHA256_ARM64

RUN apk add --no-cache \
        bash ca-certificates ccache clang21 clang21-extra-tools cmake \
        gcompat gdb git lld21 lldb luau ninja openssh-client pkgconf \
        py3-lldb stylua unzip \
    && case "${TARGETARCH}" in \
        amd64) lsp_arch="x86_64"; lsp_sha256="${LUAU_LSP_SHA256_AMD64}" ;; \
        arm64) lsp_arch="arm64"; lsp_sha256="${LUAU_LSP_SHA256_ARM64}" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && wget -q \
        "https://github.com/JohnnyMorganz/luau-lsp/releases/download/${LUAU_LSP_VERSION}/luau-lsp-linux-${lsp_arch}.zip" \
        -O /tmp/luau-lsp.zip \
    && echo "${lsp_sha256}  /tmp/luau-lsp.zip" > /tmp/luau-lsp.sha256 \
    && sha256sum -c /tmp/luau-lsp.sha256 \
    && unzip -q /tmp/luau-lsp.zip -d /usr/local/bin \
    && rm /tmp/luau-lsp.zip /tmp/luau-lsp.sha256

ENV CC=clang
ENV CXX=clang++

RUN addgroup -g 1000 dev && adduser -D -u 1000 -G dev dev
USER dev
