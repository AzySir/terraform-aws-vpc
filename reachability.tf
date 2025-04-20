# Reachability Analyzer Paths for Each Availability Zone

####################################
# Public to Private Paths
####################################
resource "aws_ec2_network_insights_path" "public_to_private_http_80" {
  for_each         = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  source           = aws_network_interface.public[each.key].id
  destination      = aws_network_interface.private[each.key].id
  protocol         = "tcp"
  destination_port = 80

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-http-80-path"
  }
}

resource "aws_ec2_network_insights_analysis" "public_to_private_http_80" {
  for_each                 = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  network_insights_path_id = aws_ec2_network_insights_path.public_to_private_http_80[each.key].id

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-http-80-analysis"
  }
}

resource "aws_ec2_network_insights_path" "public_to_private_https_443" {
  for_each         = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  source           = aws_network_interface.public[each.key].id
  destination      = aws_network_interface.private[each.key].id
  protocol         = "tcp"
  destination_port = 443

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-https-443-path"
  }
}

resource "aws_ec2_network_insights_analysis" "public_to_private_https_443" {
  for_each                 = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  network_insights_path_id = aws_ec2_network_insights_path.public_to_private_https_443[each.key].id

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-https-443-analysis"
  }
}

resource "aws_ec2_network_insights_path" "public_to_private_ssh_22" {
  for_each         = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  source           = aws_network_interface.public[each.key].id
  destination      = aws_network_interface.private[each.key].id
  protocol         = "tcp"
  destination_port = 22

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-ssh-22-path"
  }
}

resource "aws_ec2_network_insights_analysis" "public_to_private_ssh_22" {
  for_each                 = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  network_insights_path_id = aws_ec2_network_insights_path.public_to_private_ssh_22[each.key].id

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-public-to-private-${each.key}-ssh-22-analysis"
  }
}


####################################
# Private to Database Paths
####################################
resource "aws_ec2_network_insights_path" "private_to_database" {
  for_each         = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  source           = aws_network_interface.private[each.key].id
  destination      = aws_network_interface.database[each.key].id
  protocol         = "tcp"
  destination_port = 3306

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-private-to-database-${each.key}-path"
  }
}

resource "aws_ec2_network_insights_analysis" "private_to_database" {
  for_each                 = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  network_insights_path_id = aws_ec2_network_insights_path.private_to_database[each.key].id

  tags = {
    Name = "${var.org}-${var.app}-${var.env}-private-to-database-${each.key}-analysis"
  }
}

# Database to Public Paths (Expected to Fail)
resource "aws_ec2_network_insights_path" "database_to_public" {
  for_each         = var.availability_zones
  source           = aws_network_interface.database[each.key].id
  destination      = aws_network_interface.public[each.key].id
  protocol         = "tcp"
  destination_port = 3306

  tags = {
    Name = "SHOULD-FAIL-${var.org}-${var.app}-${var.env}-database-to-public-${each.key}-path"
  }
}

resource "aws_ec2_network_insights_analysis" "database_to_public" {
  for_each                 = var.enable_vpc_reachability_analyzer ? var.availability_zones : {}
  network_insights_path_id = aws_ec2_network_insights_path.database_to_public[each.key].id

  tags = {
    Name = "SHOULD-FAIL-${var.org}-${var.app}-${var.env}-database-to-public-${each.key}-analysis"
  }
}