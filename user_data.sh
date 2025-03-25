#!/bin/bash
set -e

# Update & install dependencies
sudo apt-get update -y
sudo apt-get install -y default-jdk git docker.io maven

# Enable and start Docker
sudo systemctl start docker
sudo systemctl enable docker

cd /opt
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar -xzf node_exporter-*.tar.gz
cp node_exporter-*/node_exporter /usr/local/bin/
useradd -rs /bin/false node_exporter

cat <<EOF >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

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
