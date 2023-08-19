<p align="center">
    <img src="https://cdn-botway.deno.dev/icons/bwce.svg" width="150px" />
</p>

<p align="center">
    Botway Code Editor
</p>

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
