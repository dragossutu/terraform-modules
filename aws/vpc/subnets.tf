resource "aws_subnet" "private" {
  for_each = local.subnets_private

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = merge({
    Name = "${var.name}.private.${each.key}.subnet",
  }, var.tags)
}

resource "aws_route_table_association" "private" {
  for_each = local.subnets_private

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}


resource "aws_subnet" "public" {
  for_each = local.subnets_public

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.key
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = merge({
    Name = "${var.name}.public.${each.key}.subnet",
  }, var.tags)
}

resource "aws_route_table_association" "public" {
  for_each = local.subnets_public

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}
