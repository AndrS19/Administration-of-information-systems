resource "virtualbox_vm" "andrii-sukhyi-vm" {
    name = "andrii-vm" # Назва машини
    image = "https://vagrantcloud.com/ubuntu/boxes/xenial64/versions/20180420.0.0/providers/virtualbox.box"  # Образ який потрібно використовувати
    memory = "1024 mib" 
    cpus = "1"
    boot_order  = ["disk"]
    
    network_adapter {
        type = "bridged"
        host_interface="Realtek PCIe GbE Family Controller"
    }
}