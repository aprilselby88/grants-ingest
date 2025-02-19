// Common
variable "namespace" {
  type        = string
  description = "Prefix to use for resource names and identifiers."
}

variable "function_name" {
  description = "Name of this Lambda function (excluding namespace prefix)."
  type        = string
}

variable "permissions_boundary_arn" {
  description = "ARN of the IAM policy to apply as a permissions boundary when provisioning a new role. Ignored if `role_arn` is null."
  type        = string
  default     = null
}

variable "lambda_layer_arns" {
  description = "Lambda layer ARNs to attach to the function."
  type        = list(string)
  default     = []
}

variable "lambda_artifact_bucket" {
  description = "Name of the S3 bucket used to store Lambda source artifacts."
  type        = string
}

variable "lambda_binaries_base_path" {
  description = "Path to the local directory where compiled handlers are outputted to per-Lambda subdirectories."
  type        = string
}

variable "lambda_arch" {
  description = "The target build architecture for Lambda functions (either x86_64 or arm64)."
  type        = string

  validation {
    condition     = var.lambda_arch == "x86_64" || var.lambda_arch == "arm64"
    error_message = "Architecture must be x86_64 or arm64."
  }
}

variable "log_level" {
  description = "Value for the LOG_LEVEL environment variable."
  type        = string
  default     = "INFO"
}

variable "log_retention_in_days" {
  description = "Number of days to retain logs."
  type        = number
  default     = 30
}

variable "additional_lambda_execution_policy_documents" {
  description = "JSON policy document(s) containing permissions to configure for the Lambda function, in addition to any defined by this module."
  type        = list(string)
  default     = []
}

variable "additional_environment_variables" {
  description = "Environment variables to configure for the Lambda function, in addition to any defined by this module."
  type        = map(string)
  default     = {}
}

variable "datadog_custom_tags" {
  description = "Custom tags to configure on the DD_TAGS environment variable."
  type        = map(string)
  default     = {}
}

// Module-specific
variable "email_delivery_bucket_name" {
  description = "Name of the S3 bucket that will invoke this Lambda function with newly-received emails."
  type        = string
}

variable "email_delivery_object_key_prefix" {
  description = "S3 key prefix for email file objects delivered to the email delivery bucket."
  type        = string
  default     = ""
}

variable "grants_source_data_bucket_name" {
  description = "Name of the S3 bucket to which received emails will be copied for further processing upon successful verification."
  type        = string
}

variable "allowed_email_senders" {
  description = "Allow-listed domain names and/or email addresses for FFIS email senders."
  type        = list(string)
  validation {
    condition     = length(var.allowed_email_senders) > 0
    error_message = "At least one domain must be specified or all emails will be rejected."
  }
}
