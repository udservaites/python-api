#!/bin/bash -e
NEXT_RELEASE="$1"

# Update Poetry version if lock file exist
if [ -f poetry.lock ]; then
    poetry version ${NEXT_RELEASE}
    poetry export -f requirements.txt -o requirements.dep.txt --with dev,lint,test,docs,profile
fi

# Update Version file if it exist
if [ -f VERSION ]; then
    echo "${NEXT_RELEASE}" > VERSION
fi

sed -ri "s,image: reg.git.act3-ace.com/neuroscience-research/programming-practice/python-api:.*,image: reg.git.act3-ace.com/neuroscience-research/programming-practice/python-api:${NEXT_RELEASE}," k8s/server/deployment.yml
