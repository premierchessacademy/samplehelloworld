resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [module.api-gateway.execution_arn]

  create_duration = "120s"
}

resource "aws_api_gateway_usage_plan" "APIUsagePlan" {
  count = length(var.stage_names1)
  name         = var.stage_names1[count.index]
  description  = "${var.stage_names1[count.index]} Usage Plan"
  product_code = ""
  tags = var.tags

  depends_on = [time_sleep.wait_60_seconds]

  
  
 # for_each = toset(var.stage_names1)
 api_stages {
      api_id = module.api-gateway.id
      stage = var.stage_names1[count.index]
    }



  quota_settings {
    limit  = 20
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

 