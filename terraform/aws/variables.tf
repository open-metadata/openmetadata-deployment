variable "eks_cluster" {
  type        = string
  description = "Name of the EKS cluster where OpenMetadata will be deployed."
}

variable "eks_nodes_sg_ids" {
  type        = list(string)
  description = "List of security group IDs attached to the EKS nodes. Used to allow traffic from the OpenMetadata application to the databases."
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to encrypt database and backups. Your account's default KMS key will be used if not specified."
  default     = null
}

variable "region" {
  type        = string
  description = "AWS region name, for example:`us-east-2`."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets IDs where the databases and OpenSearch will be deployed. The recommended configuration is to use private subnets."
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy the databases and OpenSearch. For example: `vpc-xxxxxxxx`."
}


# OpenMetadata application

variable "app_version" {
  type        = string
  description = "The version of the OpenMetadata application to deploy."
  default     = "1.11.5"
}

variable "app_helm_chart_version" {
  type        = string
  description = "The version of the OpenMetadata Helm chart to deploy. If not specified, the variable `app_version` will be used."
  default     = null
}

variable "app_namespace" {
  type        = string
  default     = "openmetadata"
  description = "Namespace to deploy the OpenMetadata application."
}

variable "docker_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-eu-west-1"
  description = "Full path of the server Docker image name, excluding the tag."
}

variable "docker_image_tag" {
  type        = string
  default     = null
  description = "Docker image tag for both the server and ingestion. If not specified, the variable `app_version` will be used."
}

variable "ingestion_image_name" {
  type        = string
  default     = "118146679784.dkr.ecr.eu-west-1.amazonaws.com/collate-customers-ingestion-eu-west-1"
  description = "Full path of the ingestion Docker image name, excluding the tag."
}

variable "ECR_ACCESS_KEY" {
  type        = string
  description = "The Access key shared by Collate to pull Docker images from ECR."
}

variable "ECR_SECRET_KEY" {
  type        = string
  description = "The Secret Key shared by Collate to pull Docker images from ECR."
}

variable "initial_admins" {
  type        = list(string)
  description = "List of initial admins to create in the OpenMetadata application. Do not include the domain name."
  default     = ["admin"]
}

variable "principal_domain" {
  type        = string
  description = "The domain name of the users. For example, `open-metadata.org`."
  default     = "open-metadata.org"
}


# Collate AI Proxy

variable "caip_enabled" {
  type        = bool
  description = "Enable or disable the Collate AI Proxy feature."
  default     = false
}

variable "caip_embedding_provider" {
  type        = string
  description = "The embedding provider to use with Collate AI Proxy. Supported providers are 'bedrock', 'openai', 'anthropic', 'google', and 'ollama'."
  default     = "bedrock"
  validation {
    condition     = contains(["bedrock", "openai", "anthropic", "google", "ollama"], var.caip_embedding_provider)
    error_message = "Invalid embedding provider. Supported providers are 'bedrock', 'openai', 'anthropic', 'google', and 'ollama'."
  }
}

variable "caip_aws_bedrock_region" {
  type        = string
  description = "The AWS region where Bedrock is available. Required if the embedding provider is set to 'bedrock'."
  default     = ""
}

variable "caip_host" {
  type        = string
  description = "The name of the Collate AI Proxy pod."
  default     = "caip-collate-ai-proxy"
}


# Collate AI Proxy chart configuration

variable "caip_validation_max_user_message_chars" {
  type        = number
  description = "Maximum characters accepted in a Collate AI Proxy user message."
  default     = 8000
}

variable "caip_llm_type" {
  type        = string
  description = "Identifier of the Collate AI Proxy LLM provider."
  default     = "bedrock"
}

variable "caip_llm_model" {
  type        = string
  description = "Model identifier used by the Collate AI Proxy LLM provider."
  default     = "anthropic.claude-sonnet-4-5-20250929-v1:0"
}

variable "caip_llm_max_iteration" {
  type        = number
  description = "Maximum reasoning iterations before Collate AI Proxy stops a request."
  default     = 30
}

variable "caip_llm_dynamic_max_iterations" {
  type        = number
  description = "Maximum dynamic reasoning iterations for the Collate AI Proxy."
  default     = 50
}

variable "caip_llm_open_ai_api_key" {
  type        = string
  description = "API key used when the Collate AI Proxy targets an OpenAI-compatible provider."
  default     = ""
}

variable "caip_llm_open_ai_base_url" {
  type        = string
  description = "Base URL for OpenAI-compatible requests from the Collate AI Proxy."
  default     = "https://api.openai.com"
}

variable "caip_llm_open_ai_chat_completions_path" {
  type        = string
  description = "Path for chat completions when using OpenAI-compatible providers."
  default     = "/v1/chat/completions"
}

variable "caip_llm_open_ai_responses_api_path" {
  type        = string
  description = "Path for legacy responses when using OpenAI-compatible providers."
  default     = "/v1/responses"
}

variable "caip_llm_open_ai_embeddings_path" {
  type        = string
  description = "Path for embeddings when using OpenAI-compatible providers."
  default     = "/v1/embeddings"
}

variable "caip_llm_open_ai_moderations_path" {
  type        = string
  description = "Path for content moderation when using OpenAI-compatible providers."
  default     = "/v1/moderations"
}

variable "caip_llm_open_ai_azure_open_ai_enabled" {
  type        = bool
  description = "Enable Azure OpenAI specific logic for the Collate AI Proxy."
  default     = false
}

variable "caip_llm_open_ai_azure_open_ai_api_version" {
  type        = string
  description = "Azure OpenAI API version used by the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_open_ai_azure_open_ai_deployment_name" {
  type        = string
  description = "Azure OpenAI deployment name serving the Collate AI Proxy model."
  default     = ""
}

variable "caip_llm_open_ai_azure_open_ai_resource_name" {
  type        = string
  description = "Azure resource name hosting the Collate AI Proxy deployment."
  default     = ""
}

variable "caip_llm_anthropic_api_key" {
  type        = string
  description = "API key used for Anthropic requests from the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_anthropic_base_url" {
  type        = string
  description = "Base URL for Anthropic API calls from the Collate AI Proxy."
  default     = "https://api.anthropic.com"
}

variable "caip_llm_anthropic_api_version" {
  type        = string
  description = "API version used for Anthropic requests in the Collate AI Proxy."
  default     = "2023-06-01"
}

variable "caip_llm_google_api_key" {
  type        = string
  description = "API key used for Google Generative AI within the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_google_base_url" {
  type        = string
  description = "Base URL for Google Generative AI calls from the Collate AI Proxy."
  default     = "https://generativelanguage.googleapis.com"
}

variable "caip_llm_bedrock_aws_access_key_id" {
  type        = string
  description = "AWS access key ID for Bedrock requests issued by the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_bedrock_aws_secret_access_key" {
  type        = string
  description = "AWS secret access key for Bedrock requests issued by the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_bedrock_aws_region" {
  type        = string
  description = "AWS region hosting the Bedrock endpoint for the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_bedrock_aws_session_token" {
  type        = string
  description = "AWS session token for temporary Bedrock credentials in the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_bedrock_base_url" {
  type        = string
  description = "Bedrock service base URL override for the Collate AI Proxy."
  default     = ""
}

variable "caip_llm_bedrock_enable_logging" {
  type        = bool
  description = "Enable verbose logging for Bedrock requests issued by the Collate AI Proxy."
  default     = false
}

variable "caip_llm_bedrock_request_timeout_millis" {
  type        = number
  description = "Request timeout in milliseconds for Bedrock calls made by the Collate AI Proxy."
  default     = 900000
}

variable "caip_llm_bedrock_connect_timeout_millis" {
  type        = number
  description = "Connection timeout in milliseconds for Bedrock calls made by the Collate AI Proxy."
  default     = 900000
}

variable "caip_llm_bedrock_socket_timeout_millis" {
  type        = number
  description = "Socket timeout in milliseconds for Bedrock calls made by the Collate AI Proxy."
  default     = 900000
}

variable "caip_llm_ollama_base_url" {
  type        = string
  description = "Base URL of the Ollama server targeted by the Collate AI Proxy."
  default     = "http://localhost:11434"
}


# OpenMetadata database

variable "db_instance_class" {
  type        = string
  description = "OpenMetadata database instance type."
  default     = "db.m7g.large"
}

variable "db_instance_name" {
  type        = string
  default     = "openmetadata"
  description = "Name of the OpenMetadata database instance."
}

variable "db_iops" {
  description = "The amount of provisioned IOPS for OpenMetadata database. Setting this implies a db_storage_type of 'io1' or `gp3`."
  type        = number
  default     = null
}

variable "db_major_version" {
  type        = string
  description = "OpenMetadata database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive."
  default     = "16"

  validation {
    condition     = contains(["12", "13", "14", "15", "16"], var.db_major_version)
    error_message = "Invalid PostgreSQL version. The version must be '12', '13', '14', '15', or '16'"
  }
}

variable "db_parameters" {
  type        = list(map(string))
  default     = []
  description = "List of parameters to use in the OpenMetadata database parameter group."
}

variable "db_storage" {
  type        = string
  description = "OpenMetadata database storage size."
  default     = 100
}

variable "db_storage_type" {
  type        = string
  description = "OpenMetadata database storage type."
  default     = "gp3"
}

variable "db_storage_throughput" {
  description = "OpenMetadata storage throughput value for the DB instance. Setting this implies a db_storage_type of 'io1' or `gp3`."
  type        = number
  default     = null
}


# Argo Workflows

variable "argowf_helm_chart_version" {
  type        = string
  description = "The version of the Argo Workflows Helm chart to deploy."
  default     = "0.40.8"
}


# Argo Workflows database

variable "argowf_db_instance_class" {
  type        = string
  description = "Argo Workflows database instance type."
  default     = "db.t4g.micro"
}

variable "argowf_db_instance_name" {
  type        = string
  default     = "argowf"
  description = "Name of the Argo Workflows database instance."
}

variable "argowf_db_iops" {
  description = "The amount of provisioned IOPS for Argo Workflows database. Setting this implies a db_storage_type of 'io1' or `gp3`."
  type        = number
  default     = null
}

variable "argowf_db_major_version" {
  type        = string
  description = "Argo Workflows database major version. For PostgreSQL, must be a string representing a version between '12' and '16', inclusive."
  default     = "16"

  validation {
    condition     = contains(["12", "13", "14", "15", "16"], var.argowf_db_major_version)
    error_message = "Invalid PostgreSQL version. The version must be '12', '13', '14', '15', or '16'"
  }
}

variable "argowf_db_storage" {
  type        = string
  description = "Argo Workflows database storage size."
  default     = 50
}

variable "argowf_db_storage_type" {
  type        = string
  description = "Argo Workflows database storage type."
  default     = "gp3"
}

variable "argowf_db_storage_throughput" {
  description = "Argo Workflows storage throughput value for the DB instance. Setting this implies a db_storage_type of 'io1' or `gp3`."
  type        = number
  default     = null
}


# S3 Bucket

variable "s3_bucket_name" {
  type        = string
  description = "The name of S3 bucket for storing the Argo Workflows logs and OpenMetadata assets. If not specified, a random name will be generated with the `openmetadata-` prefix."
  default     = null
}


# Search engine (OpenSearch)

variable "opensearch_name" {
  type        = string
  description = "The OpenSearch domain name."
  default     = "openmetadata"
}
