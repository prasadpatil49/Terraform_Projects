variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket"
}


variable "bucket_versioning" {
  type = string
  description = "The versioning of the S3 bucket"
  default = "Disabled"
  validation {
    condition = contains(["Enabled", "Disabled"], var.bucket_versioning)
    error_message = "The bucket_versioning must be either Enabled or Disabled."
  }
}

variable "bucket_tags" {
  type = map(string)
  description = "The tags of the S3 bucket"
}

variable "index_document" {
  type = string
  description = "The index document of the S3 bucket"
  default = "index.html"
}

variable "error_document" {
  type = string
  description = "The error document of the S3 bucket"
  default = "error.html"
}

variable "copy_source_files" {
  type = bool
  description = "The copy source of the S3 bucket"
  default = true
}

variable "source_files" {
  type = string
  description = "The source files of the S3 bucket"
}