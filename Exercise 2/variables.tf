# TODO: Define the variable for aws_region

variable "aws_region" {
 type = string
 description = "The AWS region."
 default     = "ca-central-1"
}


variable "lambda_name" {
  type        = string
  default     = "lambda_udacity"
  description = "Lambda function name"
}


