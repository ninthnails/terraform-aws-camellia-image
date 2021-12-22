## Running Ansible Playbook on Docker Container

The Docker image is only a more convenient and faster way for developing Ansible playbook.
It is in no way meant to be used for running in production environment.
The goal is to emulate an EC2 instance using Amazon Linux 2 AMI.

### Preparation

Generate the client SSH key used by Ansible to connect to the container as `ec2-user`.
```shell
mkdir -p ssh/client
ssh-keygen -f ssh/client/id_rsa -N '' -t rsa -b 2048 -C 'ec2-user@camelia'
```

### Build the image

```shell
docker compose build
```

**Note**: On macOS with Apple M1 silicon, you must build the image for Linux amd64 architecture.
Docker Compose doesn't support specifying the target platform, you need to build the image this way:
```shell
docker build -t camelia-packer-ec2:latest --platform 'linux/amd64' .
```

### Run the container

```shell
docker compose up -d

# Alternatively, using docker run
docker run --rm -dit -h camelia -p 2222:22 --privileged --memory-swap 0 --name packer-ec2 \
  --platform 'linux/amd64' -v "${PWD}/ssh/client/id_rsa.pub:/home/ec2-user/.ssh/authorized_keys:ro" \
  camelia-packer-ec2:latest
```

### Run the Ansible playbook

```shell
ansible-playbook -u ec2-user --private-key ssh/client/id_rsa -i 127.0.0.1:2222, ansible/build.yaml
```

### Connect to the container

You can connect to the container either using `exec` command or by using SSH.
```shell
# Docker exec
docker compose exec ec2 bash

# SSH
ssh -i ssh/client/id_rsa ec2-user@127.0.0.1 -p 2222
```
