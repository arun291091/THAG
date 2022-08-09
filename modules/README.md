



## Task 1 :

Created a terraform template to create VPC, ASG, LB, SG, EC2 with nginx and tested the same in my account. I have created as a module as well for reusability. 
Also, attached the terraform plan output for your reference

## Task 2 : 

The requirement was pretty confusing to me.  However, I assumed that we need a script to scale in and scale out based on the needs and to gather the data for visibility.

file : task2-script.sh

## Task 3 :

Import the diagram "task3.drawio" to draw.io to view the architecture or check the screenshot image in the repo.

Specs :

We can use M series large instances as a node in k8s to accept high traffic
We can use cluster autoscaler (horizontal or vertical pod autoscaler) based on the inflow
We can keep the manifest in github , which includes ArgoCD manifest, app manifest, Crossplane manifest for AWS resources like RDS, EKS, Kinesis, VPC, Endpoints, SG ,subnets etc..
Using Argo CD , we can deploy app to k8s and allow connectivity between the services using the endpoints
