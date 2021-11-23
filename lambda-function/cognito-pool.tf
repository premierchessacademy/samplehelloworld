
resource "aws_cognito_user_pool" "pool" {
  name = "mypool"
}

resource "null_resource" "cognito_user" {

  triggers = {
    user_pool_id = aws_cognito_user_pool.pool.id
  }

  provisioner "local-exec" {
    command = "aws cognito-idp admin-create-user --user-pool-id ${aws_cognito_user_pool.pool.id} --username myuser"
  }
}
