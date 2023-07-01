FROM botwayorg/coder:latest

ARG PASSWORD GIT_REPO GITHUB_TOKEN PKGS

RUN brew install $PKGS

RUN gh repo clone $GIT_REPO /root/workspace

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/entrypoint" ]
