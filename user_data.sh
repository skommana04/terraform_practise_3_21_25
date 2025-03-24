#!/bin/bash
set -e

# Update & install dependencies
sudo apt-get update -y
sudo apt-get install -y default-jdk git docker.io maven

# Enable and start Docker
sudo systemctl start docker
sudo systemctl enable docker

docker pull karthik0741/images:petclinic_img

docker run -e MYSQL_URL=jdbc:mysql://${mysql_url}/petclinic -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=petclinic -p 80:8080 docker.io/karthik0741/images:petclinic_img

# Run PostgreSQL container
# Wait for PostgreSQL to be ready
#sleep 20

# Clone PetClinic app
#git clone https://github.com/skommana04/spring-petclinic.git
#cd /opt/spring-petclinic

# Build the app
#./mvnw package

# Run the app using the `postgres` Spring profile in background
#nohup java -Dspring.profiles.active=postgres -jar target/*.jar >/opt/spring-petclinic/app.log 2>&1 &
