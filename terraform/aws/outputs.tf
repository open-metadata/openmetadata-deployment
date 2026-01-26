output "access_openmetadata" {
  value = {
    run_first   = "kubectl port-forward service/openmetadata 8585:8585 -n openmetadata"
    then_browse = "http://localhost:8585"
  }
}

output "openmetadata_server_irsa_role_arn" {
  description = "ARN of the IAM role associated with the OpenMetadata server service account."
  value       = module.irsa_role_server.iam_role_arn
}
