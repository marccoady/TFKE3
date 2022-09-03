# ------ eks/main.tf


resource "aws_eks_cluster" "tfckesproj" {
  name     = var.cluster_name
  role_arn = aws_iam_role.tfckesproj.arn

  vpc_config {
    subnet_ids              = var.aws_pb_sn
    endpoint_public_access  = var.endnt_pb_acc
    endpoint_private_access = var.endpnt_pvt_acc
    public_access_cidrs     = var.pb_cidrs
    security_group_ids      = [aws_security_group.node_group_a.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.tfckesproj-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.tfckesproj-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "tfckesproj" {
  cluster_name    = aws_eks_cluster.tfckesproj.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.role2.arn
  subnet_ids      = var.aws_pb_sn
  instance_types  = var.instance

  remote_access {
    source_security_group_ids = [aws_security_group.group_a.id]
    ec2_ssh_key               = var.key_pair
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.tfckesproj-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tfckesproj-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tfckesproj-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_security_group" "node_group_one" {
  name_prefix = "node_group_one"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_iam_role" "role1" {
  name = "eks-cluster-tfckesproj"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tfckesproj-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.role1.name
}

resource "aws_iam_role" "role2" {
  name = "eks-node-group-tfckesproj"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "tfckesproj-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.role2.name
}

resource "aws_iam_role_policy_attachment" "tfckesproj-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.role2.name
}

resource "aws_iam_role_policy_attachment" "tfckesproj-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.role2.name
}