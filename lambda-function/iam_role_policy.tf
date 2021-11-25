resource "aws_iam_policy" "quizwizard_api_logstream_policy" {
  
  name = "pca-lambda-log-accesspolicy"
  path = "/"
  description = "IAM policy for quizwizard API"
  policy = data.aws_iam_policy_document.lambda_policies.json
 
}


data "aws_iam_policy_document" "lambda_policies" {
dynamic "statement" {
    for_each = var.lambda_functions
    iterator = role
    content {
      effect = "Allow"
      resources = ["arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/lambda/${role.value}:*"]     
             
      actions = ["logs:CreateLogStream","logs:PutLogEvents"]
      
    }
  }


}


#data "aws_iam_policy" "SecretManagerReadWriteAccess" {
#  arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
#}

#data "aws_iam_policy" "ExecuteOtherLambda" {
#  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
#}






resource "aws_iam_role_policy_attachment" "lambda_role_policy" {
  count    = length(var.lambda_functions)
  role = aws_iam_role.lambdaroles[count.index].name
  policy_arn = aws_iam_policy.quizwizard_api_logstream_policy.arn
}



data "template_file" "lambda_rolepolicy" {
  count    = length(var.lambda_functions)
  template = file("policies/${var.lambda_functions[count.index]}/${var.lambda_functions[count.index]}.json")
}



resource "aws_iam_role" "lambdaroles" {
   count    = length(var.lambda_functions)
   name = var.lambda_functions[count.index]
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
 
}


resource "aws_iam_policy" "rolepolicy" {
  count    = length(var.lambda_functions)
  name = var.lambda_functions[count.index]
  policy = data.template_file.lambda_rolepolicy[count.index].rendered
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  count    = length(var.lambda_functions)
  role = aws_iam_role.lambdaroles[count.index].name
  policy_arn = aws_iam_policy.rolepolicy[count.index].arn
}