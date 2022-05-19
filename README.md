# cloud-native-toolkit
A simple starter toolkit for using select cloud native technologies with cyverse

# Introduction
The CyVerse Cloud Native Toolkit is a introduction to some cloud native technologies that is compatible or used by CyVerse.

# Prerequesites
The toolkit assumes the following:
* access to a kubernetes (k8s) compatible cluster
* basic-level command line linux experience
* basic-level kubernetes experience

# Getting Started
To get started, start here. These instructions assume you have a shell to an linux account that has its kubernetes environment setup.
1. `git clone https://github.com/CyVerse-Ansible/ansible-k8s-argo.git` # this repo
2. `cd ansible-k8s-argo/setup`
3. `chmod a+x install.sh`
4. `sudo ./install.sh`

# post-install
1. `export NATS_URL=nats://``kubectl get svc nats -o jsonpath='{.spec.clusterIP}'``:4222`
2. `nats server check connection`
