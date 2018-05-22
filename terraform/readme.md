# Terrafor deploy to aws

This section explain how do complete deploy of devops-challenge api and web application on AWS cloud.

1. Install AWSCLI.

  `$pip install wascli`

2. Configure aws credencials

`$aws configure`

3. Edit file `terraform.tfvars` to define variables will be used to deploy application

|Variable|Definition|
|---|---|
|region|AWS region when application will be deployed|
|availability_zones|AWS avaliables zones to previus selected region|
|environment|The environment's name when application will be deployed|
|database_name| The database's name will be create and used by application|
|database_username|Database's user name|
|database_password|Database's password|
|api_image|Docker image will be use by api application|
|api_port|Port will be used by api application|
|web_image|Docker image will be use by web application|
|web_port|Port will be used by web application|

4. Run `terrafom init` to get all modules dependencies

$terraform init`

5. Run `terraform apply` to deploy you application to AWS (note: amazon can be billing some value your credit card)

`$terraform apply`

6. Type `yes` in `Enter a value:` to confirm terraform provision on you AWS account

7. Get coffee and be happy :D, The action of provision will be slow

6. Get the endpoys `alb_web_dns_name`.

7. Go to url `http://<alb_web_dns_name.value>:<web_port>` 
