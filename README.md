# Botway Code Editor

> Botway CE is built on top of [Coder](https://coder.com)

## Build

```bash
docker build --build-arg PASSWORD="" \
    --build-arg GIT_REPO="" \
    --build-arg GITHUB_TOKEN="" \
    -t my-editor .
```

## Run

```bash
docker run -p 8080:8080 my-editor
```
