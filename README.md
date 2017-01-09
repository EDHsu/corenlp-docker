# Stanford CoreNLP Docker Image

_Note: Be sure your Docker Environment has at least 4096MB RAM_

## Create a Docker-Machine

    docker-machine create \
        --driver virtualbox \
        --virtualbox-memory 4096 \
        local
    eval "$(docker-machine env local)";

## Run the server

    docker run -d -p 9000:9000 \
        --name corenlp \
        samartioli/corenlp

###### Logs

    d logs -f corenlp

###### Stats

    docker stats

## Test it

    # Note: First time you hit the service it will take a while to load.. maybe minutes.
    curl --data 'Lets go fishing on Sunday.' http://$(dm ip local):9000

## Build

    export VERS=$(cat image.version);
    docker build -t corenlp:$VERS .

    docker rm -f corenlp
    docker run -d -p 9000:9000 \
        --name corenlp \
        corenlp:$VERS
