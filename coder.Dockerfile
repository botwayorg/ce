FROM debian:stable-slim

### Required Packages ###
RUN apt-get update -yq \
    && apt-get install -y sqlite3 lsb-release git-core curl gnupg sudo build-essential wget openssl ruby ruby-dev libopus-dev opus-tools binutils libssl-dev zlib1g-dev libboost-system-dev libcurl4-openssl-dev libffi-dev python-dev-is-python3 ffmpeg build-essential autoconf automake libtool m4 youtube-dl

### Homebrew ###
RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH
ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"

RUN echo 'export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH' >> /root/.profile

RUN brew update && brew install gh node abdfnx/tap/botway railwayapp/tap/rlwy mongodb/brew/mongodb-community mysql redis

RUN npm i -g npm@latest pnpm@latest yarn@latest

### Setup Coder ###
ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json
COPY entrypoint /usr/bin/entrypoint

RUN chmod 755 /usr/bin/entrypoint

RUN curl -fsSL https://code-server.dev/install.sh | sh

### PostgreSQL ###
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update -yq \
    && apt-get install -y postgresql
