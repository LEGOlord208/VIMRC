terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.1.2"
    }
  }
}

variable vultr_api_key {}

provider vultr {
  api_key = var.vultr_api_key
  rate_limit = 700
  retry_limit = 3
}

resource vultr_ssh_key main {
  name = "Personal"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPRNU1yPnVxZtK/qrOkAnp5J+EqXJ6wTeXOScw2lhqWg (none)"
}

resource vultr_startup_script install_nixos {
  name = "nixos-infect"
  script = base64encode(
    <<EOF
    curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | PROVIDER=vultr bash
    EOF
  )
}

resource vultr_instance main {
  plan = "vc2-1c-1gb" # $5 server plan
  region = "ams"

  os_id = 413 # Ubuntu 20.10 x64
  script_id = vultr_startup_script.install_nixos.id

  ssh_key_ids = [ vultr_ssh_key.main.id ]

  enable_ipv6 = true
}

resource vultr_reverse_ipv4 rdns {
  instance_id = vultr_instance.main.id
  ip = vultr_instance.main.main_ip
  reverse = "mail.krake.one"
}
resource vultr_reverse_ipv6 rdns {
  instance_id = vultr_instance.main.id
  ip = vultr_instance.main.v6_main_ip
  reverse = "mail.krake.one"
}

output server_ipv4 {
  value = vultr_instance.main.main_ip
}
output server_ipv6 {
  value = vultr_instance.main.v6_main_ip
}
