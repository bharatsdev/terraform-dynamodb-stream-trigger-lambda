data "aws_region" "current" {}
data "aws_caller_identity" "user" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "./dynamodb_stream/index.js"
  output_path = "./dynamodb_stream/dynamodb_stream.zip"
}

data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetShardIterator",
      "dynamodb:DescribeStream",
      "dynamodb:ListStreams"
    ]
    effect    = "Allow"
    resources = [module.dynamodb.dynamodb_table_arn, "${module.dynamodb.dynamodb_table_arn}/*"]
  }

  statement {
    actions   = ["logs:*"]
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
