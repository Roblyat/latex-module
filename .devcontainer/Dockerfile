FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# 1. Root setup: tools, user
RUN apt-get update && \
    apt-get install -y sudo curl git make locales ca-certificates gnupg2 wget xz-utils && \
    groupadd --gid 1000 ubuntu && \
    useradd -s /bin/bash --uid 1000 --gid 1000 -m ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu

# 2. Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# 3. Switch to user ubuntu
USER ubuntu
WORKDIR /home/ubuntu

# 4. Install TeX Live 2025 (full)
RUN curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    sudo perl install-tl --no-interaction && \
    cd .. && rm -rf install-tl-* install-tl-unx.tar.gz

# 5. Add TeX Live to PATH
ENV PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

# 6. Install packages as user (with sudo)
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-science \
        texlive-bibtex-extra \
        biber \
        latexmk \
        python3-pygments \
        pandoc \
        git \
        curl \
        locales \
        make \
        chktex \
        texlive-extra-utils && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# # 4. Set locale
# RUN sudo locale-gen en_US.UTF-8
# ENV LANG=en_US.UTF-8
# ENV LANGUAGE=en_US:en
# ENV LC_ALL=en_US.UTF-8

# 7. Install VS Code Server + Extensions
# Install code-server (headless VS Code)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set password for code-server (change this!)
# ENV PASSWORD="latex"

# Install VS Code LaTeX extensions
RUN code-server --install-extension mathematic.vscode-latex && \
    code-server --install-extension James-Yu.latex-workshop

# 8. Expose default VS Code port
# EXPOSE 8080

# 9. Run code-server on container start
# CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]

# Ensure SSH authentication works inside the container
ENV SSH_AUTH_SOCK=/ssh-agent