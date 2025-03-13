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