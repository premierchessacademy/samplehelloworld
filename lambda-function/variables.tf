variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "aws_account" {
   
}

# variable allowed_cidr {
#     default = ["207.141.125.0/24","63.170.46.0/24","65.172.252.0/22","65.171.4.0/22","205.242.82.0/23","207.140.132.0/23","207.140.134.0/24","208.11.196.0/22"]
#     description = "allowed cidr range for api access"
# }

variable "log_group_name" {
   
}

variable lambda_functions {
  
}

variable env_props {

}


 variable path_parts {
     default = []
     description = "API Paths"
 }

 variable http_methods {
     default = []
     description = "HTTP Methods"


 }
 

 variable integration_types {

      default = []
     description = "Integration Methods"
 }


variable  integration_http_methods{


       default = []
     description = "Integration HTTP  Methods"
}

variable stage_names1{


     default = ["qa","prod"]
     description = "Stage names for api deployment"
}

variable tags{
  default     = {"owner" : "abhilash","application": "PCAAutomation"} 
}


variable "apikey_count" {
  default     = 2
}

variable apikey_names {
  default     = ["apikey1","apikey2"]
}

variable apikey_names_desc {
  default     = ["apikey1","apikey2"]
}

variable authorizer_count {

    default = 2
}


variable authorizer_names{


    default = ["test1","test2"]
}


variable authorizer_uri{

   default =   ["arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:236970877969:function:HelloWorld1/invocations", "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:236970877969:function:HelloWorld2/invocations"]
}



