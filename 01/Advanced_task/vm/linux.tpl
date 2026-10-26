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
  - |
    if getent group docker >/dev/null 2>&1; then
      usermod -aG docker ${username}
    else
      echo "Warning: docker group does not exist yet; skipping usermod"
    fi
