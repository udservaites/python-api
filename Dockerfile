FROM docker.io/python:3.10.5 as develop


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# TODO Copy files
WORKDIR /python_api
COPY . ./

# TODO install python packages
RUN pip install -r requirements.txt

# TODO expose port
EXPOSE 8000

# TODO command or entrypoint
ENTRYPOINT ["uvicorn", "main:app", "--reload", "--host=0.0.0.0", "--port=8000"]