FROM docker.io/library/amazonlinux:2

# Amazon Linux 2 Docker image is not the full distribution like on their AMI.
# We need to install few basic things we normally found on the AMI.
RUN yum install -y \
# We are patching some of the cloud-init files
cloud-init \
hostname \
initscripts \
# Needed for Ansible to gather facts, i.e. ansible_default_ipv4
iproute \
openssh-server \
shadow-utils \
# Needed for Ansible to become root
sudo \
tar \
# This install su command
util-linux \
unzip \
&& yum clean all \
&& rm -rf /var/cache/yum

# Disable cloud-init and cloud-config, we don't need it and it makes container strart up longer.
RUN systemctl disable cloud-config \
&& systemctl disable cloud-init \
&& rm -fr /etc/systemd/system/cloud-config.target.wants /usr/lib/systemd/system/cloud-config.service \
&& rm -fr /etc/systemd/system/cloud-init.target.wants /usr/lib/systemd/system/cloud-init.service

# Configure and enable the sshd service.
RUN sed -i \
-e 's/#UseDNS yes/UseDNS no/g' \
-e 's/PasswordAuthentication yes/PasswordAuthentication no/g' \
-e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' \
/etc/ssh/sshd_config \
&& systemctl enable sshd

# Create the default user found on the AMI, add it to the sudoers.
RUN adduser -G wheel ec2-user \
&& su ec2-user -c 'mkdir -p /home/ec2-user/.ssh; chmod 0700 /home/ec2-user/.ssh' \
&& echo '%wheel    ALL=(ALL)    NOPASSWD: ALL' >> /etc/sudoers

# SSH server is listening on this port
EXPOSE 22

# Main process is systemd
ENTRYPOINT ["/usr/sbin/init"]
