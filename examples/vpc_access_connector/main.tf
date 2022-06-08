module "stromtropper" {
  source         = "../../VPC_Access_Connector"
  gcp_project_id = var.project_id
  connector_name = "stromtropper"
  vpc_name       = var.vpc_name
  ip_cidr_range  = "10.3.0.0/28"
}
