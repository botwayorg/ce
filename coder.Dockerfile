FROM botwayorg/packages:latest

ENV SHELL=/bin/bash
ENV PORT=8080

COPY settings.json /root/.local/share/code-server/User/settings.json

### Nodejs ###
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

RUN npm i -g npm@latest pnpm@latest yarn@latest

### PostgreSQL ###
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update -y \
    && apt-get install -y postgresql

RUN curl -fsSL https://code-server.dev/install.sh | sh
