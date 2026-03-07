# code_server_c
Code server web instance ready for C and Python, including caddy as reverse proxy and automatic DNS with Porkbun. 
This can be used for coding interviews by starting the instance and giving a password to the candidate.

## Features
- Main use case: online coding tests for recruiting, with C and Python support.
- C packages include gcc, g++, gdb, make, CMake, google test framework.
- Python packages include python3 and pip
- Packages caddy as reverse proxy server with let's encrypt TLS and automatic DNS configuration with Porkbun

<img width="1662" height="1330" alt="image" src="https://github.com/user-attachments/assets/f1a50a03-a9e9-4d61-869a-bb01fedc84f7" />

## Contents
Includes the code server container from linuxserver.io, Caddy as reverse propy and a DNS updater for Porkbun.
I am using Porkbun for DNS, and the setup is intended to run on an AWS EC2 instance.

## AWS Preparation
I recommend a t3.small EC2 instance with Ubuntu, and a 16GB EBS volume (we need space for the containers images and builds).
Open the following ports:
- 80 (HTTP)
- 443 (HTTPS)
And of course SSH for basic config.

## Setup
I assume that you have a domain name in Porkbun and enabled API access. 
1. Clone this repo.
2. Create a .env file with the following variables:
```bash
PASSWORD="password for code server"
SUDO_PASSWORD="sudo password for the code server container"
EMAIL="your email for Caddy and let's encrypt"
PORKBUN_API_KEY="your porkbun api key"
PORKBUN_SECRET_API_KEY="your porkbun secret api key" 
PORKBUN_DOMAIN="your domain name" 
PORKBUN_SUBDOMAIN=""
PORKBUN_POLLING_INTERVAL=300

```
3. Create the subfolders `config`, `caddy_config` and `caddy_data`. 
4. Run `docker-compose up -d` to start the containers.

## Autostart
You can start the instance automatically when the VM is started with systemd.
First, create a systemd service file.
```bash
sudo nano /etc/systemd/system/codeserver.service
```
With the following contents
```INI
[Unit]
Description=Docker Compose Application
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/ubuntu/code_server_c
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```
Enable the service with
```bash
sudo systemctl enable codeserver
```
Now docker compose will start the containers automatically after the next reboot/start.
