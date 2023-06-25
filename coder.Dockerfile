FROM debian:latest

ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json

### Required Packages ###
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y sqlite3 git-core curl gnupg build-essential wget openssl ruby ruby-dev libopus-dev opus-tools binutils libssl-dev zlib1g-dev libboost-system-dev libcurl4-openssl-dev libffi-dev python-dev ffmpeg build-essential autoconf automake libtool m4 youtube-dl

### Nodejs ###
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

RUN npm i -g npm@latest pnpm@latest yarn@latest

### Go ###
RUN wget "https://dl.google.com/go/$(curl https://go.dev/VERSION?m=text).linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf "$(curl https://go.dev/VERSION?m=text).linux-amd64.tar.gz"
ENV GOROOT /usr/local/go/bin
ENV PATH /go/bin:$PATH
RUN rm "$(curl https://go.dev/VERSION?m=text).linux-amd64.tar.gz"
RUN echo 'alias go="/usr/local/go/bin/go"' >> ~/.profile

### Homebrew ###
RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH
ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"

RUN echo 'export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH' >> ~/.profile

### CMake, GitHub CLI, Deno, Botway CLI, Rust, .NET, MongoDB, MySQL, Redis and Railway CLI ###
RUN brew update && brew install cmake gh deno abdfnx/tap/botway rust rustup-init dotnet mongodb/brew/mongodb-community mysql redis railwayapp/tap/rlwy

### PostgreSQL ###
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update -y \
    && apt-get install -y postgresql

RUN curl -fsSL https://code-server.dev/install.sh | sh
