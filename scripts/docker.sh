#!/bin/bash

DM_ACTIVE=`docker-machine active`;

if [ $? -eq 0 ]
then
    echo "### INFO: Active Docker Machine is $DM_ACTIVE"
else
    echo "### ERROR: Please set an active Docker Machine" >&2
    exit 1;
fi

DM_ACTIVE_IP=`docker-machine ip $DM_ACTIVE`;
TS=`date +%s`

export CORE_NLP_VERS=$(cat image.version);
docker build -t core-nlp:$CORE_NLP_VERS .
docker rm -f core-nlp
docker run -d \
    -p 9000:9000 \
    --name core-nlp \
    core-nlp:$CORE_NLP_VERS
