
dependency "../examples/edge_cache_origin" {
  config_path = "../examples/edge_cache_origin"
  skip_outputs = true
}

include "root" {
  path = find_in_parent_folders()
}
