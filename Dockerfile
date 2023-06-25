FROM botwayorg/coder:latest

ARG PASSWORD GIT_REPO GITHUB_TOKEN

RUN gh repo clone $GIT_REPO main

EXPOSE 8080

ENTRYPOINT code-server --bind-addr 0.0.0.0:8080 main
