# Stanford CoreNLP Docker Image

<https://github.com/stanfordnlp/CoreNLP>

TODO: Add StopwordAnnotator <https://github.com/jconwell/coreNlp>

_Note: Be sure your Docker Environment has at least 4096MB RAM_

## Create a Docker-Machine

    docker-machine create \
        --driver virtualbox \
        --virtualbox-memory 6144 \
        local
    eval "$(docker-machine env local)";

## Run the server

    docker run -d -p 9000:9000 \
        --name corenlp \
        samartioli/corenlp

    de core-nlp
    curl --data 'Lets go fishing this Sunday and next Friday with Tom Brady' http://localhost:9000

## Load zh source corpus and run the server

    java -mx6g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -serverProperties StanfordCoreNLP-chinese.properties -port 9000


###### Logs

    d logs -f corenlp

###### Stats

    docker stats

## Test it

    # Note: First time you hit the service it will take a while to load.. maybe minutes.
    curl --data 'Lets go fishing this Sunday and next Friday with Tom Brady' \
        http://$(docker-machine ip local):9000

## Build

    export VERS=$(cat image.version);
    docker build -t corenlp:$VERS .

    docker rm -f corenlp
    docker run -d -p 9000:9000 \
        --name corenlp \
        corenlp:$VERS


## Push to Docker Hub

    export VERS=$(cat image.version);
    docker tag corenlp:$VERS samartioli/corenlp:$VERS
    docker tag corenlp:$VERS samartioli/corenlp:latest

    docker login
    docker push samartioli/corenlp:$VERS
    docker push samartioli/corenlp:latest
