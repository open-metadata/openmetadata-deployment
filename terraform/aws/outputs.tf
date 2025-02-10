output "access_openmetadata" {
  value = {
    run_first   = "kubectl port-forward service/openmetadata 8585:8585 -n openmetadata"
    then_browse = "http://localhost:8585"
  }
}
