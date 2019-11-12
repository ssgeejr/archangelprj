# ArchAngel
Simple Microservice Project: ArchAngel simulates a front-end composed of a single jsp and a "widget" that enabled http injection, a microservice running on a sererate IP and container (instance) which takls to a pre-seeded MongoDB container

## CLONING 
git clone --recurse-submodules git@github.com:ssgeejr/archangelprj.git

### ToDo

* containerize the Front-end and microservice (MongoDB completed)
* move the startup and overall control to docker-compose


### Important Note: If maven fails, exeute  
mvn versions:display-dependency-updates

### Index
* [Bootstrap](#bootstrap)

Clean the Environment
* [Build Application](#manually-build-and-start-the-application)
* [Clean the Environment](#clean-the-environment)
* [Build Web UI and Microservice](#build-web-ui-and-microservice)
* [Build Docker image](#build-docker-image)
* [Start the WebApp](#start-the-webapp)
* [Start the Microservice](#start-the-microservice)
* [Start MongoDB](#start-mongodb)
* [Testing](#testing)

#### Bootstrap
This section allows for the automated building and starting of the application without any general knowledge of docker, java or microservices

**To build the stable version (main branch)**

```
git clone https://github.com/ssgeejr/ArchAngel.git  
cd ArchAngel  
sh bootstrap
```

**To build the develop branch**

```
git clone https://github.com/ssgeejr/ArchAngel.git  
cd ArchAngel  
git pull origin develop  
sh bootstrap
```

### Manually build and start the application

**this assumes you have done the following:**  
*indifferent to the branch you are working with, ensure you are in the ArchAngel directory*

```
git clone https://github.com/ssgeejr/ArchAngel.git  
cd ArchAngel  
```

**To build the develop branch**

```
git clone https://github.com/ssgeejr/ArchAngel.git  
cd ArchAngel  
git pull origin develop  
```


### Clean the Environment

```
docker stop seededdb
docker rmi -f $(docker images | grep 'mongo:seeded' | awk '{print $3}')
kill -9 $(ps -ef | grep '[a]rchAngelService.jar' | awk '{print $2}')
kill -9 $(ps -ef | grep '[a]rchAngelFrontEnd.jar' | awk '{print $2}')
rm -rf .extract
rm -rf frontend/.extract
rm -rf service/.extract
```

#### Build Web UI and Microservice

```
mvn clean package  
```

#### Build Docker image

```
cd database/docker
docker build --tag mongodb:seeded .
```

#### Start the WebApp

```
cd frontend
java -jar target/archAngelFrontEnd.jar &
```

#### Start the Microservice

```
cd ../service
java -jar target/archAngelService.jar --httpPort=9000 & 
```

#### Start MongoDB

```
docker run --name seededdb --rm -ti -p 27017:27017 mongodb:seeded
```

#### Testing
Point your browser to http://localhost:8080  

You should see the Web UI, sleect a Car Model and Search for the data (only a single row will return)  
(if the instance is running on a remote server, substitute that IP for localhost)  

