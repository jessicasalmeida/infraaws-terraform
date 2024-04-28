resource "aws_key_pair" "restaurante-kp" {
  key_name   = "${var.eks_instance_name}_key_pair"
  public_key = file(var.ssh_pubkey_file)
}