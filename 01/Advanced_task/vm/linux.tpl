#cloud-config
datasource:
  Ec2:
    strict_id: false

locale: ru_RU.UTF-8
timezone: Asia/Novokuznetsk

users:
  - name: ${username}
    groups: wheel, docker
    lock_passwd: false
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ${ssh_public}
