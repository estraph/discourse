FROM ubuntu:20.04

# fundamental ubuntu packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -yqq update && apt-get -yqq install --no-install-recommends \
    apt-transport-https apt-utils build-essential dialog software-properties-common sudo

# see https://aka.ms/vscode-remote/containers/non-root-user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# see https://github.com/sudo-project/sudo/issues/42
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && echo "Set disable_coredump false" >> /etc/sudo.conf \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USER_UID:$USER_GID

# TODO redis service
# RUN sudo add-apt-repository ppa:chris-lea/redis-server

# see https://github.com/discourse/discourse/blob/master/docs/DEVELOPER-ADVANCED.md
RUN  sudo apt-get -yqq install advancecomp curl debconf-utils expect gifsicle git git-core gnupg2 imagemagick jhead jpegoptim \
                               iproute2 less libcurl4-openssl-dev libffi-dev libgdbm-dev libjpeg-turbo-progs libncurses5-dev \
                               libpcre3 libpcre3-dev libreadline6-dev libssl-dev libsqlite3-dev libxml2 libyaml-dev lsb-release \
                               openssh-client openssl optipng pngcrush pngquant procps redis-server vim zlib1g-dev

# ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo 'PATH=${HOME}/.rbenv/bin:${PATH}' >> ~/.bashrc \
    && echo 'eval "$(~/.rbenv/bin/rbenv init -)"' >> ~/.bashrc \
    && eval "$(~/.rbenv/bin/rbenv init -)" \
    && mkdir -p ~/.rbenv/plugins \
    && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && ~/.rbenv/bin/rbenv install 2.6.2 \
    && ~/.rbenv/bin/rbenv global 2.6.2 \
    && gem install bundler debase mailcatcher rake ruby-debug-ide \
    && echo 'gem: --no-document' >> ~/.gemrc
    
# TODO psql service
# Postgresql
# RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
#     && sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
#     && sudo apt-get -yqq update \
#     && sudo apt-get -yqq install postgresql-10 pgadmin4
#     && sudo -u postgres -i \
#     && createuser --superuser -Upostgres $USERNAME \
#     && psql -c "ALTER USER $USERNAME WITH PASSWORD 'password';" \
#     && exit \

# node
RUN git clone https://github.com/nodenv/nodenv.git ~/.nodenv \
    && echo 'PATH=${HOME}/.nodenv/bin:${PATH}' >> ~/.bashrc \
    && echo 'eval "$(~/.nodenv/bin/nodenv init -)"' >> ~/.bashrc \
    && eval "$(~/.nodenv/bin/nodenv init -)" \
    && mkdir -p ~/.nodenv/plugins \
    && git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build \
    && ~/.nodenv/bin/nodenv install 12.18.1 \
    && ~/.nodenv/bin/nodenv global 12.18.1 \
    && npm install -g svgo

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get -yqq update \
    && sudo apt-get -yqq install --no-install-recommends yarn

# clean up
RUN sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

# switch back to root user so vscode extension stuff doesn't blow up
USER root