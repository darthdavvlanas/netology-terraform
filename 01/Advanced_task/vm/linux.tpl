#cloud-config

locale: ru_RU.UTF-8

timezone: Asia/Novokuznetsk

users:
  - name: ${username}
    # groups: docker
    lock-passwd: false
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh-authorized-keys:
      - ${ssh_public}
runcmd:
  - usermod -aG docker ${username}
