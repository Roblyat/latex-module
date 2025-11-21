FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

##############################################
# 1. Root setup: base tools + user creation
##############################################
RUN apt-get update && \
    apt-get install -y sudo curl git make locales ca-certificates gnupg2 wget xz-utils && \
    groupadd --gid 1000 ubuntu && \
    useradd -s /bin/bash --uid 1000 --gid 1000 -m ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    locale-gen en_US.UTF-8

##############################################
# 2. Switch to user
##############################################
USER ubuntu
WORKDIR /home/ubuntu

##############################################
# 3. Install TeX Live 2025 (full install)
##############################################
RUN curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    sudo perl install-tl --no-interaction && \
    cd .. && rm -rf install-tl-* install-tl-unx.tar.gz

# Add TeX Live to PATH
ENV PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

##############################################
# 4. Install additional tools
##############################################
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

##############################################
# 5. Install code-server (headless VS Code)
##############################################
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Add code-server to PATH (if needed in later steps)
ENV PATH="/home/ubuntu/.local/bin:$PATH"

##############################################
# 6. Install VS Code LaTeX Extensions
##############################################
RUN code-server --install-extension mathematic.vscode-latex && \
    code-server --install-extension James-Yu.latex-workshop

##############################################
# 7. Copy VS Code LaTeX Workshop config
##############################################
COPY settings.json /home/ubuntu/.config/Code/User/settings.json
RUN chown -R ubuntu:ubuntu /home/ubuntu/.config

##############################################
# 8. Optional: SSH agent support
##############################################
ENV SSH_AUTH_SOCK=/ssh-agent

##############################################
# 9. Expose default code-server port
##############################################
EXPOSE 8080

##############################################
# 10. Default CMD: run code-server without auth
# NOTE: In production, set proper authentication
##############################################
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]