resource "yandex_vpc_network" "k8s_net" {
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  name           = "k8s-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.k8s_net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}