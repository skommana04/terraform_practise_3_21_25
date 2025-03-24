#!/bin/bash
set -e

# Update & install dependencies
sudo apt-get update -y
sudo apt-get install -y default-jdk git docker.io maven

# Enable and start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Run PostgreSQL container
docker run -d \
    --name postgres-petclinic \
    -e POSTGRES_USER=petclinic \
    -e POSTGRES_PASSWORD=petclinic \
    -e POSTGRES_DB=petclinic \
    -p 5432:5432 \
    postgres:13

# Wait for PostgreSQL to be ready
sleep 20

# Clone PetClinic app
git clone https://github.com/skommana04/spring-petclinic.git
cd /opt/spring-petclinic

# Build the app
./mvnw package

# Run the app using the `postgres` Spring profile in background
nohup java -Dspring.profiles.active=postgres -jar target/*.jar >/opt/spring-petclinic/app.log 2>&1 &
