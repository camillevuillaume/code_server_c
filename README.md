# code_server_c
Code server ready for C and Python. 

## Features
- Main use case: online coding tests for recruiting, with C and Python support.
- C packages include gcc, g++, gdb, make, CMake, google test framework.
- Python packages include python3 and pip

## Contents
Includes the code server container from linuxserver.io, Caddy as reverse propy and a DNS updater for Porkbun.
I am using Porkbun for DNS, and the setup is intended to run on an AWS EC2 instance.


## Setup
I assume that you have a domain name in Porkbun and enabled API access. 
1. Clone this repo.
2. Create a .env file with the following variables:
```bash
password="password for code server"
sudo_password="sudo password for the code server container"
caddy_email="your email for Caddy and let's encrypt"
porkbun_api_key="your porkbun api key"
porkbun_secret_api_key="your porkbun secret api key" 
porkbun_domain="your domain name" 
porkbun_subdomain=""
porkbun_polling_interval=300
```
3. Run `docker-compose up -d` to start the containers.


