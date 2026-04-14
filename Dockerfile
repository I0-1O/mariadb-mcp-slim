FROM python:3.11-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/MariaDB/mcp.git .

RUN pip install --no-cache-dir \
    "asyncmy>=0.2.10" \
    "fastmcp[websockets]==2.12.1" \
    "python-dotenv>=1.1.0" \
    numpy

EXPOSE 9001

CMD ["python", "src/server.py", "--host", "0.0.0.0", "--transport", "sse"]
