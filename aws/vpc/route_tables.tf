resource "aws_route_table" "private" {
  for_each = local.subnets_public

  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${var.name}.private.${each.key}.rt",
  }, var.tags)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${var.name}.public.rt",
  }, var.tags)
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${var.name}.gw",
  }, var.tags)
}
