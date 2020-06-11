provider "aws" {
 region = "${var.aws_region}"
 access_key = "${var.aws_access_key}"
 secret_key = "${var.aws_secret_key}"
}


# Prepare Lambda package
provider "archive" {}

data "archive_file" "zip" {
	type = "zip"
	source_file = "greet_lambda.py"
	output_path = "greet_lambda.zip"
}


# IAM
data "aws_iam_policy_document" "policy"{

	statement {
		sid = ""
		effect = "Allow"
		principals {
			identifiers = ["lambda.amazonaws.com"]
			type = "Service"
		}
		actions = ["sts:AssumeRole"]
	}


}

resource "aws_iam_role" "iam_udacity_lambda" {
	name = "iam_udacity_lambda"
	assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}


resource "aws_iam_policy" "lambda_policy"{
	name = "iam_udacity_lambda_policy"
	description = "Policy attachment"

	policy  = file("policy.json")

}

resource "aws_iam_policy_attachment" "policy_attach" {
	name = "policy_attach"
	roles = ["iam_udacity_lambda"]
	policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}


# Lambda
resource "aws_lambda_function" "udacity_lambda" {
  filename      = "${data.archive_file.zip.output_path}"
  function_name = "${var.lambda_name}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
  role = "${aws_iam_role.iam_udacity_lambda.arn}"
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.6"


  environment {
  	variables = {
  		greeting = "Hello"
  	}
  }

}

# CloudWatch 
#resource "aws_cloudwatch_log_group" "lambda_log_group" {
#  name = "/aws/lambda/${var.lambda_name}"

 #retention_in_days = 14
#}





# EC2 Instances 
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0f75c2980c6a5851d"
  instance_type = "t2.micro"
  subnet_id = "subnet-64daa40c"
  
}

resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0f75c2980c6a5851d"
  instance_type = "m4.large"
  subnet_id = "subnet-64daa40c"
  
}