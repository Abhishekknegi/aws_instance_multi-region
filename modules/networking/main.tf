resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
  
}
resource "aws_subnet" "this" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.subnet_cidr
    availability_zone = var.availability_zone

}

resource "aws_route_table" "this" {
    vpc_id = aws_vpc.this.id

  
}

resource "aws_route_table_association" "this" {
    subnet_id = aws_subnet.this.id
    route_table_id = aws_route_table.this.id
  
}