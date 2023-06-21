# kotlin-test

this repo for study about spring boot ci/cd


## layered JAR & docker multi stage

```bash
docker rm `docker ps -a -q`
docker rmi `docker images -q`

./scripts/run-dev.sh
```
```bash
# 1. build & docker-compse up
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
376efba42b46   39 seconds ago   ENTRYPOINT ["java" "org.springframework.boot…   0B        buildkit.dockerfile.v0
<missing>      39 seconds ago   COPY application/ ./ # buildkit                 5.9kB     buildkit.dockerfile.v0
<missing>      6 minutes ago    COPY spring-boot-loader/ ./ # buildkit          239kB     buildkit.dockerfile.v0
<missing>      6 minutes ago    COPY snapshot-dependencies/ ./ # buildkit       0B        buildkit.dockerfile.v0
<missing>      6 minutes ago    COPY dependencies/ ./ # buildkit                24.1MB    buildkit.dockerfile.v0
<missing>      14 months ago    /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago    /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago    /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago    /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago    /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago    /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago    /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB    


# 2. build & docker-compse up (no edit)
IMAGE          CREATED              CREATED BY                                      SIZE      COMMENT
376efba42b46   About a minute ago   ENTRYPOINT ["java" "org.springframework.boot…   0B        buildkit.dockerfile.v0
<missing>      About a minute ago   COPY application/ ./ # buildkit                 5.9kB     buildkit.dockerfile.v0
<missing>      6 minutes ago        COPY spring-boot-loader/ ./ # buildkit          239kB     buildkit.dockerfile.v0
<missing>      6 minutes ago        COPY snapshot-dependencies/ ./ # buildkit       0B        buildkit.dockerfile.v0
<missing>      6 minutes ago        COPY dependencies/ ./ # buildkit                24.1MB    buildkit.dockerfile.v0
<missing>      14 months ago        /bin/sh -c #(nop)  CMD ["jshell"]               0B        
<missing>      14 months ago        /bin/sh -c set -eux;   arch="$(dpkg --print-…   322MB     
<missing>      14 months ago        /bin/sh -c #(nop)  ENV JAVA_VERSION=17.0.2      0B        
<missing>      14 months ago        /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B        
<missing>      14 months ago        /bin/sh -c #(nop)  ENV PATH=/usr/local/openj…   0B        
<missing>      14 months ago        /bin/sh -c #(nop)  ENV JAVA_HOME=/usr/local/…   0B        
<missing>      14 months ago        /bin/sh -c set -eux;  apt-get update;  apt-g…   4.87MB    
<missing>      14 months ago        /bin/sh -c #(nop)  CMD ["bash"]                 0B        
<missing>      14 months ago        /bin/sh -c #(nop) ADD file:8b1e79f91081eb527…   80.4MB 


# 3. build & docker-compse up (after edit some code)
Building testapp
[+] Building 4.9s (12/12) FINISHED                                                                                      
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 38B                                                                                0.0s
 => [internal] load .dockerignore                                                                                  0.1s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/openjdk:17-jdk-slim                                             0.8s
 => [internal] load build context                                                                                  0.3s
 => => transferring context: 24.27MB                                                                               0.2s
 => CACHED [stage-1 1/5] FROM docker.io/library/openjdk:17-jdk-slim@sha256:aaa3b3cb27e3e520b8f116863d0580c438ed55  0.0s
 => [builder 2/3] COPY build/libs/*.jar app.jar                                                                    0.4s
 => [builder 3/3] RUN java -Djarmode=layertools -jar app.jar extract                                               2.2s
 => CACHED [stage-1 2/5] COPY --from=builder dependencies/ ./                                                      0.0s
 => CACHED [stage-1 3/5] COPY --from=builder snapshot-dependencies/ ./                                             0.0s
 => CACHED [stage-1 4/5] COPY --from=builder spring-boot-loader/ ./                                                0.0s
 => [stage-1 5/5] COPY --from=builder application/ ./                                                              0.2s
 => exporting to image                                                                                             0.4s
 => => exporting layers                                                                                            0.3s
 => => writing image sha256:3ae5ccdee1e587046a03e14e221ff24f3c6fd7f59991423fad9a9a0bf85906bc                       0.0s
 => => naming to docker.io/library/kotlin-test_testapp                                                             0.0s

 IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
3ae5ccdee1e5   18 seconds ago   ENTRYPOINT ["java" "org.springframework.boot…   0B        buildkit.dockerfile.v0
<missing>      18 seconds ago   COPY application/ ./ # buildkit                 5.91kB    buildkit.dockerfile.v0
<missing>      7 minutes ago    COPY spring-boot-loader/ ./ # buildkit          239kB     buildkit.dockerfile.v0
<missing>      7 minutes ago    COPY snapshot-dependencies/ ./ # buildkit       0B        buildkit.dockerfile.v0
<missing>      7 minutes ago    COPY dependencies/ ./ # buildkit                24.1MB    buildkit.dockerfile.v0
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
