variable "filename" {
  
  default = [
    "cats.txt",
    "birds.txt",
    "fish.txt"
  ]
}

variable "content" {
    default = "Hello, pets! how are you"
}

variable "prefix" {
    default = "Mrs"
}

variable "separator" {
    default = "."
}
variable "length" {
  default = "2"
}

variable "prefixes" {
    type = list
    default = [ "Mr", "Ms", "Mrs" ]
}

variable "file_content" {
  type = map
  default = {
    "statement1" = "Hello, pets! how are you"
    "statement2" = "I am a pet"
  }
}

variable "age" {
    type = set(number)
    default = [1, 2]
  
}

variable "bella" {
    type = object({
      name = string
      color = string
      age = number
      food = list(string)
      favorite_pet = bool
    })
    default = {
      name = "bella"
      color = "white"
      age = 1
      food = ["fish", "meat"]
      favorite_pet = true
      }
}

variable "kitty" {
  type = tuple([string, number])
  default = ["kitty", 2]
}

