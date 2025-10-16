# Use the official n8n image as the base (which is Alpine-based)
FROM n8nio/n8n:latest

# Switch to the root user to install packages
USER root

ENV UV_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"
ENV PIP_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"
RUN apk add --no-cache --repository http://mirrors.aliyun.com/alpine/v3.22/main \
    --repository http://mirrors.aliyun.com/alpine/v3.22/community \
    python3 uv

# Switch back to the default non-root user
USER node
