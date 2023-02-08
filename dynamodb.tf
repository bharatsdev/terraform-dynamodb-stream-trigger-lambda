module "dynamodb" {
  source = "terraform-aws-modules/dynamodb-table/aws"
  name   = "dynamodb_tf_test"

  hash_key         = "my_id"
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"


  attributes = [
    {
      name = "my_id"
      type = "N"
    }
  ]
}
