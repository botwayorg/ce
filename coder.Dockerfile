FROM homebrew/brew:latest

ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json

### Required Packages ###
RUN sudo apt-get update -y && sudo apt-get upgrade -y \
    && sudo apt-get install -y sqlite3 git-core curl gnupg build-essential wget openssl ruby ruby-dev libopus-dev opus-tools binutils libssl-dev zlib1g-dev libboost-system-dev libcurl4-openssl-dev libffi-dev python-dev-is-python3 ffmpeg build-essential autoconf automake libtool m4 youtube-dl

### CMake, GitHub CLI, Deno, Nim, PHP, Dart, Kotlin, Go, Taskfile, Gradle, Poetry, Lua, Swift, Crystal, Botway CLI, Rust, .NET, MongoDB, MySQL, Redis and Railway CLI ###
RUN brew update && brew install cmake gh deno nim php composer dart-lang/dart/dart go-task/tap/go-task kotlin go gradle swift poetry lua abdfnx/tap/botway rust rustup-init dotnet mongodb/brew/mongodb-community mysql redis railwayapp/tap/rlwy

### Nodejs ###
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

RUN npm i -g npm@latest pnpm@latest yarn@latest

### PostgreSQL ###
# RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
#     && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
#     && apt-get update -y \
#     && apt-get install -y postgresql

RUN curl -fsSL https://code-server.dev/install.sh | sh
