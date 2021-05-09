# Demp Lumen API With Docker


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To setup this project into your local machine, you need docker and docker-compose installed in your local development machine.

Install Docker

```
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

## Installation of local development copy new

Clone this repo to your local machine. 


```
git clone https://github.com/phpdots-technologies/docker-demo-api.git

or

Get the clone url from https://github.com/phpdots-technologies/docker-demo-api
```

Generate .env file. Make sure you will update database connection as per your installed MySQL credentials.

```
cp .env.local .env
```

Run start.sh file which run docker containers for web server and database server.

```
sh ./build/local/start.sh
```

### Linux only steps.

Last command will provide web server docker container IP. This IP will be used to run website in browser.

We have to update *APP_URL* in .env file according to web server docker container IP . We have to update *APP_URL* then execute below two commands.
```
sh ./build/local/stop.sh
sh ./build/local/start.sh
```

Use below command to stop docker containers.

```
sh ./build/local/stop.sh
```

Here, containers will be start into background so we need to monitor logs till it not complete installation as per below steps.

List of docker containers.

```
docker ps
```

View log of web server (Banxel website server) docker container. Here, replace *DOCKER-CONTAINER-ID* with actual docker container ID found in previous step.

```
docker logs [DOCKER-CONTAINER-ID]
```