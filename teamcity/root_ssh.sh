#!/bin/bash

mkdir /root/.ssh
cp /home/vagrant/.ssh/authorized_keys /root/.ssh
chown root:root /root/.ssh/authorized_keys
systemctl restart sshd

