Based on the assignment below required services are implemented in terraform

![image](https://user-images.githubusercontent.com/40487138/109396806-4a44b880-7959-11eb-9e52-e0c0ac29f195.png)

Pre-Requisites To Creating Infrastructure on AWS Using Terraform
•	We require AWS IAM API keys (access key and secret key) for creating and deleting permissions for all AWS resources.
•	Terraform should be installed on the machine with version 0.12
•	Install git in ec2 install to pull the repo for the terraform scripts 

**•	Note: As per the instruction I need to create mount on /var/logs directory Instead of /var/logs, I have created a directory /var/app_webserver and mounted the FS on the same  path as /var/logs is the OS log directory to I didn’t created the mount on this directory.**


Steps to implement Terraform files :

1.	Pull the git repo by below command 
git init
git pull https://github.com/neeleshmehto/mc-assignment.git
2.  initiate terraform 
terraform init
3.  Check the terraform plan there should not be any error msg in plan o/p
terraform plan 
4.  You will see all the changes in the plan output 
![image](https://user-images.githubusercontent.com/40487138/109397236-c7712d00-795b-11eb-813c-e85c0475bace.png)

5.  Now apply the plan : it should come with below screen 
![image](https://user-images.githubusercontent.com/40487138/109397248-d5bf4900-795b-11eb-9963-98621e9c3486.png)

6.  Once all the modules are executed validate in AWS console
-----------------------------------------------------------------------------------



Amazon Resources Created Using Terraform

1.	AWS VPC with 10.20.0.0/16 CIDR
2.	AWS VPC public subnets would be reachable from the internet; which means traffic from the internet can hit a machine in the public subnet
3.	AWS VPC private subnets which mean it is not reachable to the internet directly without NAT Gateway
4.	WS VPC Internet Gateway and attach it to AWS VPC.
5.	Public and private AWS VPC Route Tables.
6.	Associating AWS VPC Subnets with VPC route tables.

------------------------------------------------------------------------------------------


**Detail description of all the terraform files **

1.	Created a “provider.tf”
This is the provider file that tellTerraform to which provider you are using. Needs to update the access_key and secret_key with the required user permission 

![image](https://user-images.githubusercontent.com/40487138/109396863-a27bba80-7959-11eb-85d8-ab1aa6ec37e8.png)


2.	Create “variables.tf”
All variables will be in this file. To complete this assignment I have created below variables region, vpc cidr, private subnet cidr, ami and instance type

![image](https://user-images.githubusercontent.com/40487138/109396869-b3c4c700-7959-11eb-8c87-36546cec98b0.png)

3.	Create “modules”  I am created all the modules in the same directory we can separate all of them like for production and networking etc  

a.	Vpc.tf  

•	created resource to create vpc by using the module “"aws_vpc"”
•	Internet Gateway To get the Internet access to the VPC and attach Internet gateway to Public subnet by module “"aws_internet_gateway"”
•	Route table attach Internet Gateway with module "aws_route_table"
•	"aws_route_table_association" in public subnet

![image](https://user-images.githubusercontent.com/40487138/109396890-cdfea500-7959-11eb-860d-4f69744ca31a.png)

![image](https://user-images.githubusercontent.com/40487138/109396896-d7880d00-7959-11eb-82a6-c397ed364d4e.png)

b.	Security Group : Created security group and define ingress and egress rules

![image](https://user-images.githubusercontent.com/40487138/109396906-e4a4fc00-7959-11eb-8773-0284a80037bf.png)

c.	Elastic Load Balancer (ELB): To connect with internet created ELB in public subnet 

![image](https://user-images.githubusercontent.com/40487138/109396915-f6869f00-7959-11eb-9bec-eea7d05962a8.png)

d.	Autoscaling Group : As per the requirement created ASG in private subnet so it will connect by elb

![image](https://user-images.githubusercontent.com/40487138/109396928-0605e800-795a-11eb-8184-289aedf7a028.png)

e.	Launch configuration : With the autoscaling I called launch configuration with required volumes and inside the launch config I am calling a shell scrip to create mount points

![image](https://user-images.githubusercontent.com/40487138/109396940-16b65e00-795a-11eb-8d30-f604d9b84b8a.png)

![image](https://user-images.githubusercontent.com/40487138/109396948-1ddd6c00-795a-11eb-9bcc-70110b3287f0.png)

