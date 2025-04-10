## git configuration
- first configure the git

## Docker installation
- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine

## check docker version
- Run bellow command to check docker version

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker --version
Docker version 28.0.1, build 068a01e

```

- Run below command to check version in details

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker version
```

## Create the Dockerfile
- Create the docker file using command
```
atul@atul-Lenovo-G570:~/softbook_docker$ touch Dockerfile
```

## About Dockerfile

1. Create the `softbook_docker/Dockerfile` docker file in project root directory.
2. If you have need to create custome docker image then create the dockerfile

```
# Use the official Python image
FROM python:3.12.8

# Set the working directory
WORKDIR /softbook_docker

# This command put requirements.txt in container in specific directory
COPY ./requirements.txt /softbook_docker/requirements.txt


# This command will install dependancies in docker container
RUN pip install --no-cache-dir --upgrade -r /softbook_docker/requirements.txt

# copy source code files and directory in docker container
COPY ./app /softbook_docker/app

# copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# this is default command. It will run after container start
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

```

1. FROM python:3.12.8
   - `FROM` statement defines which image to download. It is specify that which base image will be use by container. It must be the first command in your `Dockerfile`. A Dockerfile can have multiple `FROM` statements which means the Dockerfile produces more than one image.

2. WORKDIR /softbook_docker
   - This command used to create directory in container of docker. 

3. COPY ./requirements.txt /softbook_docker/requirements.txt 
   - COPY ./requirements.txt : This command will copy the `requirements.txt` file from  current working directory of host machine. 
   - /softbook_docker/requirements.txt : This is create the `requirements.txt` file in softbook_docker directory in container of docker. If `softbook_docker` directory is not exist then docker will create this directory automatically.
   - This command required for the dependancies installation in docker container. 

4. RUN pip install --no-cache-dir --upgrade -r /softbook_docker/requirements.txt
   - This command used to install dependancies in docker container
   - pip install : This is primary command to install dependancies using pip
   - --no-cache-dir : This option ensure that no any cache will use because cache take unnecessary space. 
   - --upgrade : This option ensure that if any package already installed then this open will be install latest version of package.
   - -r /softbook_docker/requirements.txt : This option tells dependancies will be install from requirements.txt file.

5. COPY ./app /softbook_docker/app
   - This is the Dockerfile instruction used to copy files or directories from the host machine into the container during the image build process
   - ./app : The app is a directory. It contain the project directory and files like main.py and static, template etc directory.
   - ./ : This is used for current directory. Here Dockerfile will be available. 
   - /softbook_docker/app : It is directory in docker container where `./app` will be copy. 
   - If `/softbook_docker/app` this directory not available in container then docker will create automatially.

6. CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
   - It is a docker file instruction. When container start then it run default commands. 
   - uvicorn : It  handle http request for FastAPI. 
   - app.main:app : Here `app` is directory and `main` is `main.py` file that is created in `app` directory and `:app` is a opject that is written in `app/main.py` file 



## how to create docker image
1. If `softbook_docker/Dockerfile` file created in project root directory then you will create image of docker
2. go to the project root directory
```
atul@atul-Lenovo-G570:~$ cd softbook_docker
```
3. Run bellow command to build docker image. Here `sofbookdockerimage` is docker image name

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker build -t sofbookdockerimage .
```

4. You can see details of specific image by `docker inspect` command.

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker inspect sofbookdockerimage
```

5. You can see docker image list by command

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker images
```

## how to create image with tag
1. If `softbook_docker/Dockerfile` file created in project root directory then you will create image of docker.
2. first go in project root directory where docker file available  
3. Run the command: $ docker build -t <image_name>:<tag version> .

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker build -t softbookdockerimage:1.0 .
```
4. You can see details of specific image by `docker inspect` command.
 - command: $ docker inspect <image_name>:<tag name>

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker inspect softbookdockerimage:1.0
```

5. You can see docker image list by command

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker images
```

## About docker container
1. docker container is an instance of image
2. docker container is a small operating system

## create docker container and run it
1. Here `softbookdockercontainer` is container name

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker run -d -p 8000:8000 --name softbookdockercontainer sofbookdockerimage

```

2. verify running container. 
 - docker name show in Exited or Created it means container running successfully

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker ps -a

```

## create docker container but not run this container 
1. command: `:~/softbook_docker$ docker create -p <host_port>:<container_port> --name dev_container softbookdockerimage:1.0`


```
atul@atul-Lenovo-G570:~/softbook_docker$ docker create -p 8000:8000 --name dev_container softbookdockerimage:1.0

```

2. You will see the container status

- Here status is `CREATED` 
```
atul@atul-Lenovo-G570:~/softbook_docker$ docker ps -a --filter ancestor=b410fcd67bc1
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS    PORTS     NAMES
9839f284f9b1   softbookdockerimage:1.0   "uvicorn app.main:ap…"   3 minutes ago   Created             dev_container

```

## How to start container 

command: :~/softbook_docker$ docker start <container id>

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker start 9839f284f9b1

```
- you will see the container status after start. Here status is `Up 9 seconds`.  

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker ps -a --filter ancestor=b410fcd67bc1
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS         PORTS     NAMES
9839f284f9b1   softbookdockerimage:1.0   "uvicorn app.main:ap…"   5 minutes ago   Up 9 seconds             dev_container

```

## How to stop docker container

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker stop softbookdockercontainer

```
- You will see the container status after stop. Here status is `Exited (0) 9 seconds ago`
```
atul@atul-Lenovo-G570:~/softbook_docker$ docker ps -a --filter ancestor=b410fcd67bc1
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS                     PORTS     NAMES
9839f284f9b1   softbookdockerimage:1.0   "uvicorn app.main:ap…"   9 minutes ago   Exited (0) 9 seconds ago             dev_container

```

## How to restart docker container

```
atul@atul-Lenovo-G570:~/softbook_docker$ docker restart softbookdockercontainer
```

## Run uvicorn manually for test

```
atul@atul-Lenovo-G570:~/softbook_docker$ uvicorn app.main:app --reload

```

## How to see the available images list
```
atul@atul-Lenovo-G570:~$ docker images

```

## How to see all container list
```
atul@atul-Lenovo-G570:~$ docker ps -a
```

## How to see container list of specific image 

- command: $ docker ps -a --filter ancestor=<image_id>


```
atul@atul-Lenovo-G570:~$ docker ps -a --filter ancestor=315b6543b1b0

```

## how to delete a container 

- first stop the container 
- command: $ docker rm <container_id>

```
atul@atul-Lenovo-G570:~$ docker rm 7d9dc2fb0e81

```
## How to delete an image 
- first delete all containers of an image 
- command : $ docker rmi <image_id>
```
atul@atul-Lenovo-G570:~$ docker rmi 315b6543b1b0
```

## check docker container log
- By log you can see that FastAPI application runni or not


## How to use ngnix with docker 
1. https://hub.docker.com/_/nginx
2. first pull the ngix image
```
atul@atul-Lenovo-G570:~$ docker pull nginx:stable

```
3. create container for nginx image for your application 

```
atul@atul-Lenovo-G570:~$ docker run -d -p 80:80 --name softbookdocker_nginx -v $(pwd)/softbook_docker/nginx.conf:/etc/nginx/nginx.conf nginx:stable

```
## how to create network 
- here `softbook_docker_network` is network name 
```
atul@atul-Lenovo-G570:~/softbook_docker$ docker network create softbook_docker_network

```

## How to see list of networks 
```
atul@atul-Lenovo-G570:~/softbook_docker$ docker network ls

```

## how to connect container with network
- command is `$ docker network connect <network name> <container name>
`
```
atul@atul-Lenovo-G570:~/softbook_docker$ docker network connect softbook_docker_network dev_container

```

## how to see the details of network 

```
atul@atul-Lenovo-G570:~$ docker network inspect bridge

```

## How to inspect specific network

```
atul@atul-Lenovo-G570:~$ docker network inspect softbook_docker_network

```
## How to create Personal Access Token (PAT)
1. Visite on this url to create token https://app.docker.com/settings/personal-access-tokens

## How to login in docker from terminal
1. run the below command to login
   ```
   atul@atul-Lenovo-G570:~$ docker login -u atulkrishnathakur
   ```
2. Enter personal access toker (pat) in password
3. You will see
   ```
   '/home/username/.docker/config.json'.
   
   ```
## How to push image in docker hub
1. First create a repository name in docker hub. Reference: https://hub.docker.com/repositories/username
2. create repository in docker hub like `testfastapi`
3. Tag your local machine image with this repository.
   Command: `$ docker tag <local image name>:<tag> <docker user name >/<docker repository>:<tag>
   ```
   atul@atul-Lenovo-G570:~$ docker tag softbookdockerimage:1.0 atulkrishnathakur/testfastapi:1.0

   ```
4. push image on docker
   command: `$ docker push <docker user name>/<docker repository>:<tag>`
   ```
   atul@atul-Lenovo-G570:~$ docker push atulkrishnathakur/testfastapi:1.0
   
   ```
5. Note: when you run `docker images` command then you got `softbookdockerimage:1.0` and `atulkrishnathakur/testfastapi:1.0` with same image id. It means `atulkrishnathakur/testfastapi:1.0` not a new image. It is a simply new reference(tag) of the same image.
   
## How to pull specific tag of repositories from docker hub
1. You can see reporitories. Open the url https://hub.docker.com/u/username
2. click on repository name
3. click on tag to see tags of images
4. pull specific tag of an image. Command `$ docker pull <docker user name>/<repository name>:<tag>`
   ```
     atul@atul-Lenovo-G570:~$ docker pull atulkrishnathakur/testfastapi:1.0
   ```
## How to go into docker container
1 command : `$ docker exec -it <container name or container ID> /bin/bash`
```
atul@atul-Lenovo-G570:~$ docker exec -it nginx-container /bin/bash
# or
atul@atul-Lenovo-G570:~$ docker exec -it nginx-container bash
```

After running you will see.
```
root@b57dce611822:/# 

```
- Here `b57dce611822` is the container ID. And `root` is the user of container.
- Note: Container is a small operating system.
- Note: Now you can run approx all command of cmd or linux terminal

## How to go into docker container by root user
- The `-u 0` option specifies the root user (user ID 0)
- Command `docker exec -u 0 -it <container_name_or_id> bash`
```
atul@atul-Lenovo-G570:~$ docker exec -u 0 -it pgadmin4container bash
```

## How to go into docker container by specific user
- command `docker exec -u <username_or_id> -it <container_name_or_id> bash`
```
atul@atul-Lenovo-G570:~$ docker exec -u pgadmin -it pgadmin4container bash
```

## how to exit from container
command: `exit`
```
root@b57dce611822:/# exit

```
then you will see again
```
atul@atul-Lenovo-G570:~$ 

```

## how to see volume
1. Docker persistent volume will be create in host machine.
2. Persistent volume is not delete when you down or remove container
3. See the volume by command.
```
atul@atul-Lenovo-G570:~$ docker volume ls
```
2. You can see manually your volume in `/var/lib/docker/<volume_name>/` path in linux
   
## how to remove volume
command: `$ docker rm volume <volume name>`
```
atul@atul-Lenovo-G570:~$ docker rm volume greenbook_postgresdata

```
