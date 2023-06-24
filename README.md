# kotlin-test

this repo for study about spring boot ci/cd

# prepare commit msg

```js
regex="^(feat|fix|refactor|style|docs|test|chore):.{1,50}(\n.{1,72})?$"
```

# Mysql with docker-compose

```bash
> docker exec -it mysql-test bash

bash# mysql -u root -p
> root
```

# Fat Jar image VS layered JAR image

Fat Jar Image failed to cache **24 mb**, but Layered Jar image failed to cache only **5.91 KB**


## Fat Jar

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

## Layered Jar

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
