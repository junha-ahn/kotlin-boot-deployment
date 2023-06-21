# kotlin-test

docker images
docker ps -a

docker rmi `docker images -q`
docker rm `docker ps -a -q`


docker run testimage -p 8080:8080


참고
- https://start.spring.io/
- https://github.com/microsoft/vscode-dev-containers/blob/main/container-templates/docker-compose/.devcontainer/devcontainer.json
- https://stackoverflow.com/questions/32997269/copying-a-file-in-a-dockerfile-no-such-file-or-directory