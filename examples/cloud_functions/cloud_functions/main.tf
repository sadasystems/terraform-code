module "geralt_of_rivia" {
  source                             = "../../GoogleCloud/Cloud_Functions"
  gcp_project_id                     = var.project_id
  region                             = var.region
  cloud_func_name                    = "geralt-of-rivia"
  cloud_func_runtime                 = "nodejs16"
  cloud_func_source_code_bucket_name = "geralt-of-rivia"
  cloud_func_code_filename           = "index.zip"
  public_func                        = true
  cloud_func_invoker                 = ["users:rohan.singh@sada.com", "serviceAccount:rohan-orbit@appspot.gserviceaccount.com"]
}
