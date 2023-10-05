#!/bin/bash

# Update and install required packages
sudo apt-get update -y
sudo apt-get install -y docker.io

# Install kubeadm, kubelet, and kubectl
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo bash -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'
sudo apt-get update -y
sudo apt-get install -y kubeadm kubelet kubectl
