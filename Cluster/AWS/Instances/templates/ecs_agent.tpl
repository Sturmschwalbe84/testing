#!/bin/bash
sudo mkdir -p /etc/ecs
sudo echo "ECS_CLUSTER=${cluster}" > /etc/ecs/ecs.config
sudo amazon-linux-extras disable docker
sudo amazon-linux-extras install -y ecs
sudo systemctl enable --now --no-block ecs.service
