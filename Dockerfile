FROM botwayorg/coder:latest

ARG PASSWORD GIT_REPO GITHUB_TOKEN PKGS

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/entrypoint" ]
