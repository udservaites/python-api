FROM docker.io/python:3.10.5 as develop


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# TODO Copy files
COPY . /

# TODO install python packages
RUN pip install --no-cache-dir -r requirements.txt .

# TODO expose port
EXPOSE 8000

# TODO command or entrypoint
ENTRYPOINT [ "python", "main.py" ]
