 module "api-gateway" {
    #source        = "abhilashusha/api-gateway/aws"
    #source = "git@github.com:abhilashusha/terraform-aws-api-gateway.git?ref=feature/cognito-authorization"

    source = "git::https://github.com/abhilashusha/terraform-aws-api-gateway?ref=feature/cognito-authorization"
    #version       = "0.15.1"

    name        = "api-gateway"
    environment = "test"
    label_order = ["name", "environment"]
    enabled     = true

  # Api Gateway Resource
    path_parts = var.path_parts
   
  # Api Gateway Method
    method_enabled = true
    http_methods   = var.http_methods

  # Api Gateway Integration
    integration_types        = var.integration_types
    integration_http_methods = var.integration_http_methods

    uri= formatlist("arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:236970877969:function:%s/invocations",var.lambda_functions)
    #uri                      = ["", "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:${var.aws_account}:function:HelloWorld2/invocations"]
    integration_request_parameters = [{
      "integration.request.header.X-Authorization" = "'static'"
    }, {}]
    request_templates = [{
      "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
    }, {}]

  # Api Gateway Method Response
    status_codes = [200, 200]
    response_models = [{ "application/json" = "Empty" }, {}]
    response_parameters = [{ "method.response.header.X-Some-Header" = true }, {}]

  # Api Gateway Integration Response
    integration_response_parameters = [{ "method.response.header.X-Some-Header" = "integration.response.header.X-Some-Other-Header" }, {}]
    response_templates = [{
      "application/xml" = <<EOF
  #set($inputRoot = $input.path('$'))
  <?xml version="1.0" encoding="UTF-8"?>
  <message>
      $inputRoot.body
  </message>
  EOF
    }, {}]

  # Api Gateway Deployment
   deployment_enabled = true
   #stage_name         = "qa"

   stage_enabled = true
   stage_names   = var.stage_names1


  # Api Gateway Stage
   #stage_enabled = true
   #stage_names   = ["qa", "dev"]

  # Api Gateway Client Certificate
  #  cert_enabled     = false
  #  cert_description = "clouddrove"

  # Api Gateway Authorizer
   # authorizations=["COGNITO_USER_POOLS","COGNITO_USER_POOLS"]
   # authorizer_count                = 1
   # authorizer_names                = ["test"]
   # authorizer_uri   = formatlist("arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:236970877969:function:%s/invocations",var.lambda_functions)
   # authorizer_ids = [for path in var.path_parts: module.api-gateway.authorizer_id[0]]
   
   
   # identity_sources                = ["method.request.header.Authorization", "method.request.header.Authorization"]
   # identity_validation_expressions = ["",""]
   # authorizer_types                = ["COGNITO_USER_POOLS","COGNITO_USER_POOLS"]
    #authorization_scopes  = ["aws.cognito.signin.user.admin","aws.cognito.signin.user.admin"]
  
   

  #  provider_arns = [aws_cognito_user_pool.pool.arn,aws_cognito_user_pool.pool.arn]
   


  # Api Gateway Gateway Response
   # gateway_response_count = 2
   # response_types         = ["UNAUTHORIZED", "RESOURCE_NOT_FOUND"]
   # gateway_status_codes   = ["401", "404"]

  # Api Gateway Model
  #  model_count   = 2
  #  model_names   = ["test", "test1"]
  # content_types = ["application/json", "application/json"]

  # Api Gateway Api Key
  #  key_count = 2
  #  key_names = ["test", "test1"]


  }



resource "aws_lambda_permission" "lambda_permission1" {
  
  count       = length(var.lambda_functions)

  statement_id  = var.lambda_functions[count.index]
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[count.index]
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  //source_arn = "${aws_lambda_function.dns_automation.arn}/*/POST/dns"
  source_arn = "${module.api-gateway.execution_arn}/*/${var.http_methods[count.index]}/${var.path_parts[count.index]}"
   
   depends_on = [
  
    aws_lambda_function.quizwizard_api_lambdas

  ]

}




output "base_urls1" {
  value = module.api-gateway.base_urls[0]
}

output "stage_names" {
  value = var.stage_names1
}
