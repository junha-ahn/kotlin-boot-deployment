# kotlin-test

this repo for study about spring boot ci/cd

# Terraform

for [CD: 배포를 위한 환경 세팅](https://github.com/f-lab-clone/ticketing-service/issues/7)

[terraform config files](https://github.com/junha-ahn/kotlin-boot-deployment/tree/main/terraform)

# Git Actions: Build-Test-Lint with Gradle 

[gradle-build-test-lint](https://github.com/junha-ahn/kotlin-boot-deployment/blob/main/.github/workflows/gradle-build-test-lint.yml)

reference [here](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-java-with-gradle)

# commit message check

[commit-regular.txt](https://github.com/junha-ahn/kotlin-test/blob/main/commit-regular.txt)
```js
^([Mm][Ee][Rr][Gg][Ee].*)$|^(feat|fix|refactor|style|docs|test|chore):.{1,50}(\n.{1,72})?$
```

### git actions

[commit-msg-check.yml](https://github.com/junha-ahn/kotlin-test/blob/main/.github/workflows/commit-msg-check.yml)

### prepare-commit-msg hook

[prepare-commit-msg](https://github.com/junha-ahn/kotlin-test/blob/main/scripts/git-hooks/prepare-commit-msg)

[postCreateCommand.sh](https://github.com/junha-ahn/kotlin-test/blob/main/.devcontainer/postCreateCommand.sh)
```bash
git config --local commit.template commit-template.txt
cp scripts/git-hooks/prepare-commit-msg .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

# Mysql with docker-compose

[compose.yaml](https://github.com/junha-ahn/kotlin-test/blob/main/compose.yaml)

```bash
> docker exec -it mysql-test bash

bash# mysql -u root -p
> root
```

# Fat Jar image VS layered JAR image

[Dockerfile](https://github.com/junha-ahn/kotlin-test/blob/main/Dockerfile)

Fat Jar Image failed to cache **24 mb**, but Layered Jar image failed to cache only **5.91 KB**

reference [here](https://spring.io/guides/topicals/spring-boot-docker/)

### Fat Jar

```bash
> docker history kotlin-test_testapp
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
5c6bfb1d74f0   8 minutes ago   ENTRYPOINT ["java" "-jar" "app.jar"]            0B        buildkit.dockerfile.v0
<missing>      8 minutes ago   COPY build/libs/\*.jar app.jar # buildkit        24.3MB    buildkit.dockerfile.v0
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago   /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago   /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago   /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB    

# edit a single line - Failed to cache 24 MB

> docker history kotlin-test_testapp
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
33afaf8a6a1d   1 seconds ago   ENTRYPOINT ["java" "-jar" "app.jar"]            0B        buildkit.dockerfile.v0
<missing>      1 seconds ago   COPY build/libs/\*.jar app.jar # buildkit        24.3MB    buildkit.dockerfile.v0
<missing>      14 months ago    /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago    /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago    /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago    /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago    /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago    /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB    
```

### Layered Jar

```bash
> docker history kotlin-test_testapp
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
9a589029194b   5 seconds ago   ENTRYPOINT ["java" "org.springframework.boot…   0B        buildkit.dockerfile.v0
<missing>      5 seconds ago   COPY application/ ./ # buildkit                 5.9kB     buildkit.dockerfile.v0
<missing>      23 hours ago    COPY spring-boot-loader/ ./ # buildkit          239kB     buildkit.dockerfile.v0
<missing>      23 hours ago    COPY snapshot-dependencies/ ./ # buildkit       0B        buildkit.dockerfile.v0
<missing>      23 hours ago    COPY dependencies/ ./ # buildkit                24.1MB    buildkit.dockerfile.v0
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago   /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago   /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago   /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB    

# edit a single line - Failed to cache only 5.91 KB
> docker history kotlin-test_testapp
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
f77f5b4823cd   1 seconds ago   ENTRYPOINT ["java" "org.springframework.boot…   0B        buildkit.dockerfile.v0
<missing>      1 seconds ago   COPY application/ ./ # buildkit                 5.91kB    buildkit.dockerfile.v0
<missing>      23 hours ago    COPY spring-boot-loader/ ./ # buildkit          239kB     buildkit.dockerfile.v0
<missing>      23 hours ago    COPY snapshot-dependencies/ ./ # buildkit       0B        buildkit.dockerfile.v0
<missing>      23 hours ago    COPY dependencies/ ./ # buildkit                24.1MB    buildkit.dockerfile.v0
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago   /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago   /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago   /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago   /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB
```
