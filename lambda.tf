module "lambda" {
  depends_on = [
    module.dynamodb
  ]
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "dynamodb_stream"
  source_path   = "./dynamodb_stream/"
  runtime       = "nodejs14.x"
  handler       = "index.handler"

  allowed_triggers = {
    dynamodb = {
      service    = "dynamodb"
      source_arn = module.dynamodb.dynamodb_table_stream_arn
    }
  }
  create_current_version_allowed_triggers = false
  publish                                 = true

  attach_policy_json = true
  policy_json        = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_lambda_event_source_mapping" "trigger" {
  event_source_arn  = module.dynamodb.dynamodb_table_stream_arn
  function_name     = module.lambda.lambda_function_arn
  starting_position = "LATEST"
}
