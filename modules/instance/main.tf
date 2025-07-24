# Fetch the latest Amazon Linux 2 AMI from AWS SSM Parameter Store
data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Create an EC2 instance
resource "aws_instance" "this" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2.value
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.name
  }
  lifecycle {
  ignore_changes = [
    ami,                 # AMI updates may happen outside Terraform
    ebs_block_device,    # EBS volumes resized manually
    user_data,           # User data scripts updated dynamically
    instance_type,       # Instance type changed by auto-scaling
    tags,                # Tags managed by external tools (e.g., AWS Config)
  ]
}
}

