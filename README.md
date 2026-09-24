# Домашнее задание к занятию «Установка Kubernetes»

### Цель задания

Установить кластер K8s.

### Чеклист готовности к домашнему заданию

1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.


### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/).

-----
### Подготовка инфраструктуры

Инфраструктура была построена с помощью terraform в Yandex Cloud

[Ссылка на папку terraform](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/terraform/)

Output terraform:

```sh
external_ips = {
  "k8s-vm-1" = "158.160.53.11"
  "k8s-vm-2" = "158.160.59.69"
  "k8s-vm-3" = "158.160.46.45"
  "k8s-vm-4" = "158.160.49.85"
  "k8s-vm-5" = "51.250.85.226"
}
internal_ips = {
  "k8s-vm-1" = "192.168.10.14"
  "k8s-vm-2" = "192.168.10.33"
  "k8s-vm-3" = "192.168.10.3"
  "k8s-vm-4" = "192.168.10.9"
  "k8s-vm-5" = "192.168.10.7"
}
```
![VMS](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/img/vms.png)

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

Заполнили inventory файл и проверили доступность хостов модулем "Ping"

[Ссылка на inventory](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/inventory.ini)

![Ping](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/img/success_ping_pong.png)

После этого установили все зависимости из папки Kubespray и запустили playbook

ansible-playbook -i inventory/mycluster/inventory.ini --become --become-user=root cluster.yml

Успешное выполнение playbook:

![Success playbook](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/img/success_ping_pong.png)

Далее заходим на нашу мастер ноду и проверяем список нод. Далее деплоим простейший nginx для проверки

![List of nodes](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/img/check_nodes_deploy_nginx.png)

Проверяем сервис etcd и служебные поды

![Etcd + calico](https://github.com/deadwhitepunk/hw-k8s-09/blob/main/img/etcd+calico.png)

## Дополнительные задания (со звёздочкой)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой необязательные к выполнению и не повлияют на получение зачёта по этому домашнему заданию. 

------
### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl get nodes`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.