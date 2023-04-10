# docker-with-non-root-user-sample
A sample code snippet for demostrating docker with non root user access

## Run the container

    docker build -t docker-with-non-root .

    docker run -p 8080:8080 docker-with-non-root

    docker run -p 8080:8080 --user non_root_user:non_root_user  docker-with-non-root
