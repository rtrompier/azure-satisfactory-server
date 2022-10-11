terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.4.0"
    }
  }

  backend "remote" {
    organization = "rtrm"
    workspaces {
      name = "satisfactory-server-scaleway"
    }
  }
}

provider "scaleway" {
  # Configuration options
}


# resource "scaleway_instance_volume" "data" {
#   size_in_gb = 100
#   type = "b_ssd"
# }

resource "scaleway_instance_ip" "ip" {}

# resource "scaleway_instance_server" "web" {
#   type = "DEV1-S"
#   image = "ubuntu_jammy"
# 
#   tags = [ "hello", "public" ]
# 
#   root_volume {
#     delete_on_termination = false
#   }
# 
#   additional_volume_ids = [ scaleway_instance_volume.data.id ]
# 
#   user_data = {
#     foo        = "bar"
#     cloud-init = file("./init.yml")
#   }
# }
