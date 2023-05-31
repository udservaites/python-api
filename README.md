# python-api

A simple microservice python application that can be used to test the CI pipeline. It creates a simple REST HTTP server.

python-api is designed to:

- <!--replace this with purpose 1-->
- <!--replace this with purpose 2-->
- <!--replace this with purpose 3 or delete, and so on-->

python-api has features such as:

- <!--replace this with feature 1-->
- <!--replace this with feature 2-->
- <!--replace this with feature 3 or delete, and so on-->

## Documentation

The documentation for python-api is organized as follows:

- **[Quick Start Guide](docs/quick-start-guide.md)**: provides documentation of prerequisites, downloading, installing, and configuring python-api.
<!--Modify the description above, as needed, based on the product and what sections are actually in the doc -->
- **[User Guide](docs/user-guide.md)**: provides a conceptual overview of python-api by explaining key concepts. This doc also helps users understand the benefits, usage, and best practices for working with python-api.

## How to Contribute

- **[Developer Guide](docs/developer-guide.md)**: detailed guide for contributing to the python-api repository.

### Usage

#### Setup Local Server

Run the following to start the server.

Run Poetry install to install all required packages.
Please visit [Poetry offical website](https://python-poetry.org/docs/basic-usage/) for more information

```bash
poetry install
```

Run server.

```bash
poetry run uvicorn python_api.main:app --reload
```

or

navigate to the python_api directory and then run
`poetry run uvicorn main:app --reload`

```bash
cd python_api 
poetry run uvicorn main:app --reload
```

The reload tag will reload the server everytime a change is made to the main.py file

#### Deploy to Kubernetes

First setup your Kubernetes environment,
Then run the following to start Deployment.

Create pull secret:
Use docker credential.

```bash
kubectl create secret docker-registry python-api-secret --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<project access token or a deploy token> --docker-email=<your-email>
```

For more information, check [Kubernetes.io/pull-image-private-registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)

Deploy to Kubernetes using skaffold:

```bash
skaffold run
```

View your server on [dashboard](https://dashboard.lion.act3-ace.ai/)

### Organization

- Source code is in /python_api/
- Unit tests go in /test
- Functional tests go in /ftest
- All runtime dependencies go in install_requires in setup.py **and** environment.yml

### API Documentation

Documentation can be served locally with

```bash
pip install "mkdocs<1.1" mkdocs-macros-plugin mkdocs-mermaid-plugin inari[mkdocs] pymdown-extensions
mkdocs build
```

Then open a web browser to see the docs.  The web page should automatically refresh.

### API Testing

API Testing can be done with Swagger-UI that is deployed with the OpenAPI based servers.  If using a path altering reverse proxy please see the api.yaml file for usage instructions.

There are better testing tools for APIs than Swagger-UI that allow you to save your queries and build up a reusable test suite for your API.  With Swagger-UI everything is gone when you refresh the page.
See [TESTING.md](ftest/TESTING.md) for one such tool.

- **[Troubleshooting FAQ](docs/troubleshooting-faq.md)**: consult list of frequently asked questions and their answers.
- **Mattermost channel(<!-- replace this with a URL and make link active -->)**: create a post in the python-api channel for assistance.
- **Create a GitLab issue by email(<!-- replace this with a URL and make link active -->)**

## ACE-Hub

Lunch ACE-hub using this [URL](https://hub.lion.act3-ace.ai/environments/0?replicas=1&image=reg.git.act3-ace.com/neuroscience-research/programming-practice/python-api/cicd:latest&hubName=python-api&proxyType=normal&resources[cpu]=1&resources[memory]=1Gi&shm=64Mi)(or without VPN use [this](https://hub.ace.act3.ai/environments/0?replicas=1&image=reg.git.act3-ace.com/neuroscience-research/programming-practice/python-api/cicd:latest&hubName=python-api&proxyType=normal&resources[cpu]=1&resources[memory]=1Gi&shm=64Mi).)
