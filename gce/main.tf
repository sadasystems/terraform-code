# values for testing purpose only

module "mandalorian_vm" {
  source                = "../../GoogleCloud/GCE/GCE_Instance"
  gcp_project_id        = var.project_id
  vpc_subnetwork_name   = var.subnet_name
  instance_name         = "mandalorian"
  instance_machine_type = "e2-standard-2"
  create_external_ip    = true
  boot_disk_device_name = "mandalorian"
  boot_disk_image       = "ubuntu-2110"
  boot_disk_size        = 200
  network_tags          = ["allow-https", "allow-http"]
  vm_enable_display     = true
}