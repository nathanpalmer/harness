FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        bubblewrap \
        ca-certificates \
        curl \
        git \
        ripgrep \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN useradd --create-home --shell /bin/bash codex \
    && mkdir -p /workspace \
    && chown codex:codex /workspace

USER codex

ENV CODEX_HOME=/home/codex/.codex \
    CODEX_INSTALL_DIR=/home/codex/.local/bin \
    CODEX_NON_INTERACTIVE=1 \
    PATH=/home/codex/.grok/bin:/home/codex/.kimi-code/bin:/home/codex/.local/bin:$PATH

RUN mkdir -p "$CODEX_HOME" "$CODEX_INSTALL_DIR" \
    && curl -fsSL https://chatgpt.com/codex/install.sh | sh \
    && codex --version

RUN curl -fsSL https://claude.ai/install.sh | bash \
    && claude --version

RUN curl -fsSL https://code.kimi.com/kimi-code/install.sh | bash \
    && kimi --version

RUN curl -fsSL https://x.ai/cli/install.sh | bash \
    && grok --version

WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]
