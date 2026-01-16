resource "helm_release" "caip" {
  count      = var.caip_enabled ? 1 : 0
  name       = "caip"
  repository = "https://helm.open-metadata.org"
  chart      = "collate-ai-proxy"
  version    = local.omd.helm_chart_version
  namespace  = kubernetes_namespace.app.id
  wait       = false
  values = [
    templatefile("${path.module}/helm-dependencies/caip_config.tftpl",
      {
        caip_validation_max_user_message_chars         = var.caip_validation_max_user_message_chars
        caip_llm_type                                  = var.caip_llm_type
        caip_llm_model                                 = var.caip_llm_model
        caip_llm_max_iteration                         = var.caip_llm_max_iteration
        caip_llm_dynamic_max_iterations                = var.caip_llm_dynamic_max_iterations
        caip_llm_open_ai_api_key                       = var.caip_llm_open_ai_api_key
        caip_llm_open_ai_base_url                      = var.caip_llm_open_ai_base_url
        caip_llm_open_ai_chat_completions_path         = var.caip_llm_open_ai_chat_completions_path
        caip_llm_open_ai_responses_api_path            = var.caip_llm_open_ai_responses_api_path
        caip_llm_open_ai_embeddings_path               = var.caip_llm_open_ai_embeddings_path
        caip_llm_open_ai_moderations_path              = var.caip_llm_open_ai_moderations_path
        caip_llm_open_ai_azure_open_ai_enabled         = var.caip_llm_open_ai_azure_open_ai_enabled
        caip_llm_open_ai_azure_open_ai_api_version     = var.caip_llm_open_ai_azure_open_ai_api_version
        caip_llm_open_ai_azure_open_ai_deployment_name = var.caip_llm_open_ai_azure_open_ai_deployment_name
        caip_llm_open_ai_azure_open_ai_resource_name   = var.caip_llm_open_ai_azure_open_ai_resource_name
        caip_llm_anthropic_api_key                     = var.caip_llm_anthropic_api_key
        caip_llm_anthropic_base_url                    = var.caip_llm_anthropic_base_url
        caip_llm_anthropic_api_version                 = var.caip_llm_anthropic_api_version
        caip_llm_google_api_key                        = var.caip_llm_google_api_key
        caip_llm_google_base_url                       = var.caip_llm_google_base_url
        caip_llm_bedrock_aws_access_key_id             = var.caip_llm_bedrock_aws_access_key_id
        caip_llm_bedrock_aws_secret_access_key         = var.caip_llm_bedrock_aws_secret_access_key
        caip_llm_bedrock_aws_region                    = var.caip_llm_bedrock_aws_region
        caip_llm_bedrock_aws_session_token             = var.caip_llm_bedrock_aws_session_token
        caip_llm_bedrock_base_url                      = var.caip_llm_bedrock_base_url
        caip_llm_bedrock_enable_logging                = var.caip_llm_bedrock_enable_logging
        caip_llm_bedrock_request_timeout_millis        = var.caip_llm_bedrock_request_timeout_millis
        caip_llm_bedrock_connect_timeout_millis        = var.caip_llm_bedrock_connect_timeout_millis
        caip_llm_bedrock_socket_timeout_millis         = var.caip_llm_bedrock_socket_timeout_millis
        caip_llm_ollama_base_url                       = var.caip_llm_ollama_base_url
      }
    )
  ]
}
