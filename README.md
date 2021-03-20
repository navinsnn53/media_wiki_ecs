## Requirements
The modules were tested and run against Terraform version : Terraform v0.13.4
Docker version 19.03.6-ce, build 369ce74 with ecs agent AMI

## Folder structure
- ansible_LAMP: For normal LAMP setup installation for media wiki with standalone machine
- ansible_ecs_deployment: ECS based deployment with ansible and aws-cli
- terraform: For spinning up ECS cluster in AWS cloud.

## Pre-Req

1. Terraform to be installed with version v0.13.4 or above
2. Ansible to be installed
3. Bake an AMI which has ecs agent installed and docker version 19.03.6-ce, build 369ce74 to be used for ECS cluster

## ECS Docker Container Image from Appcontainers

This container is build from appcontainers. This docker image helps to run a customisable mediawiki setup with single docker run command. All docker orchestration is done by Elastic Container Service. Running a standalone instance with both Application and Mysql in same instance.

## Container Variables

* APP_NAME: To setup fully qualified Domain name
* MYSQL_SERVER: This is the mysql host where the app DB is stored
* MYSQL_CLIENT: Hostname of the computer making connection from Application 
* MYSQL_USER: Mysql User which is used to connect to application with grant permissions 
* APP_USER: Username Application will use toc onnect


Docker file in guthib:

https://github.com/wikimedia/mediawiki-docker



