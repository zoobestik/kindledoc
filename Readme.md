# Pandoc for Kindle 12 Paperwhite

The project provides a simple [docker-based](https://github.com/zoobestik/kindledoc/pkgs/container/kindledoc) workflow for converting Markdown
files into Kindle-optimized PDFs suited for the 12th-gen Kindle Paperwhite,
focusing on readability and correct rendering of code/emoji.

## Usage

```bash
# Checkout the script
mkdir -p ~/code/pandoc
curl -s https://raw.githubusercontent.com/zoobestik/kindledoc/main/pandoc.sh > ~/code/pandoc/pandoc.sh

# Add alias
echo "alias kindledoc='~/code/pandoc/pandoc.sh'" >> ~/.zshrc
```

Run with:
```Bash
kindledoc filepath.md
```

## Development

```bash
# Build base the docker image
export SCRIPT_DIR=$(pwd) # "..."

export GH_USERNAME="zoobestik"
export IMAGE="ghcr.io/$GH_USERNAME/kindledoc:latest"

docker build --platform=linux/amd64 \
  -t "$IMAGE" "$SCRIPT_DIR"
```

## Deployment

```bash
docker login ghcr.io -u "$GH_USERNAME"
docker push "$IMAGE"
```
