variable "ami" {
    description = "The AMI ID for the EC2 instance"
    default     = "ami-05d2d839d4f73aafb"
}

variable "instance_Type" {
    description = "The instance type for the EC2 instance"
    default     = "c7i-flex.large"
}

variable "Key_Name" {
    description = "Key Name"
    default = "Batch-31"
}

variable "tag_values" {
  description = "Map of tags to assign to the resources"
  type  = map(string)
  default  = {
  Name = "Jenkins-Terraform-AWSCLI-WITHIAM"
  Environment = "Production"
  Team  = "DevOps"
  Type = "Jenkins-Terraform-AWSCLI"
  }
}

variable "S3BucketName" {
    description = "S3 Bucket Name"
    default = "shreyassangaiuniquebucket"
    }