variable "security_groups" {
  type    = list(string)
  default = []
}
variable "key_name" {
  type    = string
  default = ""
}
variable "lc_name" {
  type    = string
  default = ""
}

variable "ami_name_value" {
  type    = list(string)
  default = []
}

variable "iam_instance_profile" {
  type    = string
  default = ""
}
variable "profile_name" {
  type    = string
  default = ""
}
variable "inline_policy" {
  type    = string
  default = ""
}
variable "iam_role" {
  type    = string
  default = ""
}
variable "dynamodb_table" {
  type    = string
  default = ""
}
variable "ec2_name" {
  type    = string
  default = ""
}
variable "environment" {
  type    = string
  default = ""
}
variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}
variable "asg_name" {
  type    = string
  default = ""
}
variable "instance_type" {
  type    = string
  default = ""
}