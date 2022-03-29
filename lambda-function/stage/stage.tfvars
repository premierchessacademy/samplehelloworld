aws_region = "us-east-1"
aws_account = "236970877969"

log_group_name = "helloworld1-log-group"
env_props = {}

path_parts = ["mytestresource1","mytestresource2", "mytestresource3"]
lambda_functions = ["HelloWorld1","HelloWorld2", "HelloWorld3"]
http_methods = ["POST","POST","GET"]
integration_types = ["AWS_PROXY", "AWS_PROXY", "AWS_PROXY"]
integration_http_methods = ["POST","POST","POST"]
stage_names1 = ["qa","prod"]