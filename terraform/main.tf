resource "virtualbox_vm" "andrii-sukhyi-vm" {
    count = 2 # Цей операнд вказує скільки ресурсів буде створено
    name = "andrii-vm-${count.index + 1}" # Оскільки віртуальних машин повинно створити дві, то й імена повинні відрізнятись. В даному випадку, використовуємо звичні арифметичні дії, для ітерації.
    image = var.img  # Образ який потрібно використовувати
    memory = var.ram
    cpus = "1"
    boot_order  = ["disk"]
    
    network_adapter {
        type = "bridged"
        host_interface="Realtek PCIe GbE Family Controller"
    }
}

resource "local_file" "tf_ip" { # Ресурс local_file призначений для взаємодії з локальними файлами
    content = "[ALL]\n${virtualbox_vm.andrii-sukhyi-vm[0].network_adapter.0.ipv4_address} ansible_ssh_user=ubuntu" # В контенті ми описуємо що саме ми запишемо у файл. Якщо приглянутися, можна побачити, що структура тексту являється інвентаризацією для інструменту Ansible. Єдине чого не вистачає – це ІР адреси віртуальної машини яку ми знати не можемо, оскільки машини ще не існує. Саме тому дана конструкція ${ virtualbox_vm.my-vm[0].network_adapter.0.ipv4_address} звернеться до нульового створеного ресурсу virtualbox_vm, вичитає його ІР адресу та дасть змогу її записати.
    filename = "./inventory" # Шлях до файлу який було створено в минулому кроці.
}