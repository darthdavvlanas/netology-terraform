### Домашнее задание по первому модулю terraform.
## Чек-лист
![Чек-лист](./console-0.png)

## Задача №1

1. 
![Задача1](./console-1.png)

2. **personal.auto.tfvars** - В этом файле хранятся персональные секреты.

3. 
```
cat terraform.tfstate | grep result
            "result": "nED56d6s1D9iOQ2W",
                "value": "result"
  "check_results": null
```
4. 
![Задача1](./console-2.png)

![Задача1](./console-3.png)

**Первая ошибка** вызвана тем, что не задано имя ресурса, только его тип. \
**Вторая ошибка** связана с тем, что label может начинаться только с буквы или подвала. \
**Третья ошибка** связана с тем, что не существует ресурса с именем **random_string_FAKE** присутствует только **random_string**. \
**Четвертая ошибка** в строке 
```
name  = "example_${random_password.random_string.resulT}"
```
Т.к в **result** последняя буква заглавная, чего быть не должно, т.к terraform чувствителен к регистру.

5. 
Исправленный фрагмент **main.tf**
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "hello_world"

  ports {
    internal = 80
    external = 9090
  }
}
```

Вывод команды **docker ps**
```
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
0137614a4911   57df7715e516   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:9090->80/tcp   example_nED56d6s1D9iOQ2W
```
6. Ключ **-auto-approve** опасен тем, что сходу применяет изменения. Если при редактировании конфигурации случайно были удалены лишние ресурсы, то при вводе **terrafor apply -auto-approve** все изменения применятся сразу. Лучше всего его не использовать, а лишний раз убедиться в том, что план верный и только потом набрать **yes**. \
Использовать данный ключ будет удобно при автоматизации, т.к автоматика не будет и не может перепроверить план, а следовательно не может она осмысленно ответить и на вопрос, который задает terraform. \
Так же ключ можно использовать в тестовых средах, где совершенно не важно упадет ли какой-то сервис. Можно еще использовать при применении заранее проверенного плана.
```
╭─ fedorabook  davlanas  ~/git/education/terraform/ter-homeworks/01/src                                                                                                                                                                                                                                                                               ✔   main ●  78% (0:55) 🔋  16:13:42 
╰─ docker ps                    
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
c9f8a5397471   57df7715e516   "/docker-entrypoint.…"   3 seconds ago   Up 2 seconds   0.0.0.0:9090->80/tcp   hello_world
```
7. 
```
╭─ fedorabook  davlanas  ~/git/education/terraform/ter-homeworks/01/src                                                                                              ✔   main ●  79% 🔋  16:23:05 
╰─ cat terraform.tfstate 
{
  "version": 4,
  "terraform_version": "1.16.4",
  "serial": 11,
  "lineage": "600c3069-a7df-5aa8-a297-9af0ed4a3fac",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
8. Docker image не был удален, т.к в блоке docker_image используется аргумент **keep_localy**.

> keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.

### Задача №2*
В директории **01/Advanced_task** лежит проект развертывания ВМ и докер контейнера с mysql. Придумать, как реализовать это в рамках одного apply не вышло в силу того, что провадер инициируется раньше создания ресурсов, а в этот момент еще нет ВМ и как следствие нет remote coontext. \
Сам remote context реализовал через отдельный ресурс и local-exec, чтобы хоть на сколько-то добиться автоматизации.

# Вывод команды env
```
# docker exec -it mysql bash
bash-5.1# envv
bash: envv: command not found
bash-5.1# env 
MYSQL_MAJOR=8.4
HOSTNAME=ed0ed7d84b69
PWD=/
MYSQL_ROOT_PASSWORD=FEvz5M67DFbi4XSE
MYSQL_PASSWORD=PHDlbefEhrDLE2hY
MYSQL_USER=wordpress
HOME=/root
MYSQL_VERSION=8.4.11-1.el9
GOSU_VERSION=1.19
TERM=xterm
MYSQL_ROOT_HOST=%
SHLVL=1
MYSQL_DATABASE=wordpress
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MYSQL_SHELL_VERSION=8.4.10-1.el9
_=/usr/bin/env
```
# Вывод команды cat terraform.tfstate
```
fedorabook  davlanas  ~/git/education/terraform/netology-terraform/01/Advanced_task/docker                                                                                                                                                                                                                                                 ✔   main ?  79% 🔋  14:21:14 
╰─ cat terraform.tfstate | grep result
            "result": "FEvz5M67DFbi4XSE",
                "value": "result"
            "result": "PHDlbefEhrDLE2hY",
                "value": "result"
  "check_results": null
  ```

  ### Задача №3*
  
  Чтобы запустить opentofu потребовалось только откорректировать требуемую версию, т.к у opentofu сейчас в репозиториях fedora linux 1.11.5, а терраформ у меня 1.16.4. В остальном все влетело без лишних доработок. 
  ```
  tofu apply

OpenTofu used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

OpenTofu will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + memory_reservation                          = 0
      + must_run                                    = true
      + name                                        = (sensitive value)
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + platform                                    = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 9090
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = true
      + name         = "nginx:latest"
      + repo_digest  = (known after apply)
    }

  # random_password.random_string will be created
  + resource "random_password" "random_string" {
      + bcrypt_hash = (sensitive value)
      + id          = (known after apply)
      + length      = 16
      + lower       = true
      + min_lower   = 1
      + min_numeric = 1
      + min_special = 0
      + min_upper   = 1
      + number      = true
      + numeric     = true
      + result      = (sensitive value)
      + special     = false
      + upper       = true
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  OpenTofu will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
random_password.random_string: Creating...
docker_image.nginx: Creation complete after 0s [id=sha256:57df7715e5164e0a18083ed0370e230f9408a90a17143c2bcb75353f5016980anginx:latest]
random_password.random_string: Creation complete after 0s [id=none]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=b690d43d3794d021441338e788de081fb949d103d27d98fa51761ca29bacea97]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

```
fedorabook  davlanas  ~/git/education/terraform/ter-homeworks/01/src                                                                                            2 ↵   main ●  79% 🔋  14:34:42 
╰─ docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED          STATUS          PORTS                                                                                NAMES
b690d43d3794   57df7715e516                "/docker-entrypoint.…"   15 seconds ago   Up 14 seconds   0.0.0.0:9090->80/tcp                                                                 example_2xCrYq7w3I2vbfFo
```
