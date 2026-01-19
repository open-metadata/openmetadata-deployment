locals {
  caip = {
    validation_max_user_message_chars         = var.caip_validation_max_user_message_chars
    llm_type                                  = var.caip_llm_type
    llm_model                                 = var.caip_llm_model
    llm_max_iteration                         = var.caip_llm_max_iteration
    llm_dynamic_max_iterations                = var.caip_llm_dynamic_max_iterations
    open_ai_api_key                           = var.caip_open_ai_api_key
    open_ai_base_url                          = var.caip_open_ai_base_url
    open_ai_chat_completions_path             = var.caip_open_ai_chat_completions_path
    open_ai_responses_api_path                = var.caip_open_ai_responses_api_path
    open_ai_embeddings_path                   = var.caip_open_ai_embeddings_path
    open_ai_moderations_path                  = var.caip_open_ai_moderations_path
    open_ai_azure_open_ai_enabled             = var.caip_open_ai_azure_open_ai_enabled
    open_ai_azure_open_ai_api_version         = var.caip_open_ai_azure_open_ai_api_version
    open_ai_azure_open_ai_deployment_name     = var.caip_open_ai_azure_open_ai_deployment_name
    open_ai_azure_open_ai_resource_name       = var.caip_open_ai_azure_open_ai_resource_name
    anthropic_api_key                         = var.caip_anthropic_api_key
    anthropic_base_url                        = var.caip_anthropic_base_url
    anthropic_api_version                     = var.caip_anthropic_api_version
    google_api_key                            = var.caip_google_api_key
    google_base_url                           = var.caip_google_base_url
    bedrock_aws_access_key_id                 = var.caip_bedrock_aws_access_key_id
    bedrock_aws_secret_access_key             = var.caip_bedrock_aws_secret_access_key
    bedrock_aws_region                        = var.region
    bedrock_aws_session_token                 = var.caip_bedrock_aws_session_token
    bedrock_base_url                          = var.caip_bedrock_base_url
    bedrock_enable_logging                    = var.caip_bedrock_enable_logging
    bedrock_request_timeout_millis            = var.caip_bedrock_request_timeout_millis
    bedrock_connect_timeout_millis            = var.caip_bedrock_connect_timeout_millis
    bedrock_socket_timeout_millis             = var.caip_bedrock_socket_timeout_millis
    ollama_base_url                           = var.caip_ollama_base_url
  }
}

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
        caip = local.caip
      }
    )
  ]
}
