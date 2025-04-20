#####################
# !! Imporant Note !!
# These network interfaces are only used for testing purposes
# when running the vpc reachability analyzer
#####################

resource "aws_network_interface" "public" {
  for_each  = var.enable_vpc_reachability_analyzer ? aws_subnet.public : {}
  subnet_id = each.value.id
  // A terraform limitation that will increment the cidr by 2 for a private IP and then remove the /23 with the second call
  private_ips     = [cidrhost(each.value.cidr_block, 4)]
  security_groups = [aws_security_group.public.id]

  depends_on = [aws_subnet.public]

  tags = { 
    Name = "${var.org}-${var.app}-${var.env}-public-nic-${each.key}"
  }
}

resource "aws_network_interface" "private" {
  for_each  = var.enable_vpc_reachability_analyzer ? aws_subnet.private : {}
  subnet_id = each.value.id
  // A terraform limitation that will increment the cidr by 2 for a private IP and then remove the /23 with the second call
  private_ips     = [cidrhost(each.value.cidr_block, 4)]
  security_groups = [aws_security_group.private.id]

  depends_on = [aws_subnet.private]

  tags = { 
    Name = "${var.org}-${var.app}-${var.env}-private-nic-${each.key}"
  }
}

resource "aws_network_interface" "database" {
  for_each  = var.enable_vpc_reachability_analyzer ? aws_subnet.database : {}
  subnet_id = each.value.id
  // A terraform limitation that will increment the cidr by 2 for a private IP and then remove the /23 with the second call
  private_ips     = [cidrhost(each.value.cidr_block, 4)]
  security_groups = [aws_security_group.database.id]

  depends_on = [aws_subnet.database]

  tags = { 
    Name = "${var.org}-${var.app}-${var.env}-database-nic-${each.key}"
  }
}

