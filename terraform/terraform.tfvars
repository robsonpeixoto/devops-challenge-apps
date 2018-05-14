region              = "us-east-2"
availability_zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]
environment         = "challenge"

database_name       = "challenge"
database_username   = "DevOps01"
database_password   = "DevOps01"

api_image           = "raphaelneumann/stone-challenge-api"
api_port            = 4000

web_image           = "raphaelneumann/stone-challenge-web"
web_port            = 3000
