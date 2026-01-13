# This is an example of using the local provider to create a file locally.

terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.6.1"
    }
  }
}

resource "local_file" "pet" {
    filename = each.value
    content = data.local_file.inputfile.content
    file_permission = "0700"
    depends_on = [ random_pet.my-pet ]           # Explicit dependency
    for_each = toset(var.filename)
}

resource "random_pet" "my-pet" {
    prefix = var.prefixes[0]
    separator = var.separator
    length = var.length
}

data "local_file" "inputfile" {
    filename = "input.txt"
}

output "pet-name" {
    value = random_pet.my-pet.id
    description = "Name of the pet"
}

 output "pet_files" {
    value = local_file.pet
    description = "files created by the local_file resource"
    sensitive = true
 }



