FROM frolvlad/alpine-glibc:glibc-2.35

ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json

### Required Packages ###
RUN apk update \
    && apk add zip unzip git curl npm py3-pip openssl openssl-dev libsodium ffmpeg lld clang build-base abuild binutils opus autoconf automake libtool m4 youtube-dl binutils-doc gcc-doc python3-dev neofetch zsh sudo make lsof wget gcc asciidoctor ca-certificates bash-completion htop jq less llvm nano vim ruby-full ruby-dev libffi-dev icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib postgresql postgresql-client

RUN npm i -g npm@latest pnpm@latest yarn@latest

### Homebrew ###
RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH
ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"

RUN echo 'export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH' >> ~/.profile

### CMake, GitHub CLI, Deno, Nim, PHP, Dart, Kotlin, Go, Taskfile, Gradle, Poetry, Lua, Swift, Crystal, Botway CLI, Rust, .NET, MongoDB, MySQL, Redis and Railway CLI ###
RUN brew update && brew install cmake gh deno nim php composer dart-lang/dart/dart go-task/tap/go-task kotlin go gradle swift poetry lua abdfnx/tap/botway rust rustup-init dotnet mongodb/brew/mongodb-community mysql redis railwayapp/tap/rlwy

RUN curl -fsSL https://code-server.dev/install.sh | sh
