# mariadb-mcp-slim

A lightweight Docker image for the [MariaDB MCP Server](https://github.com/MariaDB/mcp), built without the heavy ML/embedding dependencies. The official image pulls in `sentence-transformers`, `openai`, and `google-genai`, pushing it to several gigabytes. This image strips those out and adds only `numpy` (required at import time), keeping the image under 500MB.

## What's included

- `python:3.11-slim` base
- MariaDB MCP server source cloned from [MariaDB/mcp](https://github.com/MariaDB/mcp)
- Core dependencies only: `asyncmy`, `fastmcp[websockets]`, `python-dotenv`, `numpy`
- SSE transport enabled, listening on port 9001

## Usage

```bash
docker pull mewcus/mariadb-mcp-slim:latest
```

```yaml
services:
  mariadb-mcp:
    image: mewcus/mariadb-mcp-slim:latest
    ports:
      - "9001:9001"
    environment:
      - MARIADB_HOST=your-host
      - MARIADB_PORT=3306
      - MARIADB_USER=your-user
      - MARIADB_PASSWORD=your-password
      - MARIADB_DATABASE=your-database
      - READ_ONLY=true
      - EMBEDDING_PROVIDER=None
```

## Connecting via mcp-remote

```
npx -y mcp-remote http://your-host:9001/sse --allow-http
```

## Builds

Automatically built and pushed to [Docker Hub](https://hub.docker.com/r/mewcus/mariadb-mcp-slim) via GitHub Actions on every push to `main`.
