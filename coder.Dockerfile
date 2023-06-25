FROM debian:latest

ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json

### Required Packages ###
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y sqlite3 git-core curl gnupg build-essential wget openssl ruby ruby-dev libopus-dev opus-tools binutils libssl-dev zlib1g-dev libboost-system-dev libcurl4-openssl-dev libffi-dev python-dev-is-python3 ffmpeg build-essential autoconf automake libtool m4 youtube-dl

### Nodejs ###
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

RUN npm i -g npm@latest pnpm@latest yarn@latest

### Homebrew ###
RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH
ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"

RUN echo 'export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH' >> ~/.profile

### CMake, GitHub CLI, Deno, Nim, PHP, Dart, Kotlin, Go, Taskfile, Gradle, Poetry, Lua, Swift, Crystal, Botway CLI, Rust, .NET, MongoDB, MySQL, Redis and Railway CLI ###
RUN brew update && brew install cmake gh deno nim php composer dart-lang/dart/dart go-task/tap/go-task kotlin go gradle swift poetry lua abdfnx/tap/botway rust rustup-init dotnet mongodb/brew/mongodb-community mysql redis railwayapp/tap/rlwy

### PostgreSQL ###
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update -y \
    && apt-get install -y postgresql

RUN curl -fsSL https://code-server.dev/install.sh | sh
