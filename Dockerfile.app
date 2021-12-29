FROM golang:1.16-buster AS easy-novnc-build
WORKDIR /src
# RUN go mod tidy
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM debian:buster-slim

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu tint2 && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends lxterminal zsh git nano vim curl wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

# for docker in docker
ARG DOCKERGID=998
RUN apt update -y && \
    apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt update -y && \
    groupadd --gid $DOCKERGID docker &&\  
    apt install -y  docker-ce && \
    # docker compose
    curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    echo "Docker installed"

# configure vnc and supervisord
COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/
COPY supervisord.conf /etc/
EXPOSE 8080

ARG UID=1097
ARG GID=1145


RUN groupadd --gid $GID app && \
    useradd --home-dir /data --shell /bin/bash --uid $UID --gid $GID app && \
    mkdir -p /data && \  
    chown -R app /data 
VOLUME /data


# install asdf
RUN git clone https://github.com/asdf-vm/asdf.git /opt/asdf --branch v0.8.1 \
    && chmod -R o+rw /opt/asdf \
    && echo "ASDF installed"

# customize user environment
# allow user to run docker commands
RUN usermod -aG docker app
USER app 
# install zsh
RUN curl https://raw.githubusercontent.com/danielporto/zsh-dotfiles/master/zimrc -o ~/.zimrc \
    && curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh \
    && curl https://raw.githubusercontent.com/danielporto/zsh-dotfiles/master/zshrc -o ~/.zshrc \
    && curl https://raw.githubusercontent.com/danielporto/zsh-dotfiles/master/gitconfig -o ~/.gitconfig  \
    && echo "ZSH configured, Zimfw installed"
    

RUN ls -la /data
# install GOLANG 1.14.13 or 1.16.10 
ENV GO_INSTALL_VERSION=1.16.10 
ENV PATH="/opt/asdf/bin:/opt/asdf/shims:$PATH"
RUN asdf plugin-add golang https://github.com/kennyp/asdf-golang.git && \
    asdf install golang $GO_INSTALL_VERSION && \
    asdf global golang $GO_INSTALL_VERSION && \
    echo "Golang installed"

USER root

CMD ["sh", "-c", "chown app:app /data /dev/stdout && exec gosu app supervisord"]
