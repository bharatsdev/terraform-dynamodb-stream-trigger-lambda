output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_id
}


output "dynamodb_table_stream_arn" {
  description =  "The ARN of the Table Stream. Only available when var.stream_enabled is true"
  value       = module.dynamodb.dynamodb_table_stream_arn
}