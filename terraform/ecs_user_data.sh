#!/usr/bin/env bash

{

    setupECSCluster() {
        CLUSTERNAME=$1
        echo ECS_CLUSTER="$CLUSTERNAME">> /etc/ecs/ecs.config
        yum update -y ecs-init
        sudo start ecs
    }


    installssmagent() {
       sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
    }

    install_telnet(){
      sudo yum install telnet -y
    }

    main() {
        env=${env}
        CLUSTERNAME=${ecs_cluster_name}
        setupECSCluster $CLUSTERNAME
    }
    main

} >> /var/log/user_data.out