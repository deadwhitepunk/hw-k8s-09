data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "k8s" {
  count       = 5
  name        = "k8s-vm-${count.index + 1}"
  hostname    = "k8s-vm-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.k8s_subnet.id
    nat                = true
  }
  
  scheduling_policy { preemptible = true }

  metadata = {
      user-data          = file("./cloud-init.yml")
      serial-port-enable = 1
    }
}

output "external_ips" {
  value = {
    for i, vm in yandex_compute_instance.k8s :
    "k8s-vm-${i + 1}" => vm.network_interface[0].nat_ip_address
  }
}

output "internal_ips" {
  value = {
    for i, vm in yandex_compute_instance.k8s :
    "k8s-vm-${i + 1}" => vm.network_interface[0].ip_address
  }
}