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

# this is default command. It will run after container start
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]

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
3. Run bellow command to build docker image