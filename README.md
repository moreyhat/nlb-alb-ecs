# Path based routing app with Static IP example
This is an example architecture realizing Path-based routing with Static IP addresses by using AWS NLB (Network Load Balancer) and ALB (Application Load Balancer).  

ALB provides a path-based load balancing feature, however the IP addresses of it may dynamically change, which may be a challenge in some case.  For example, domain name of ALB could not be resolved in hybrid enviromnent.  

NLB provides a feature of static IP address and ALB is supported as a load balancing target of NLB. So, we can realize Path-based routing with Static IP address by using this feature.

# Architecture
As an example, we can deploy the following architecture example by using CloudFormation [template.yaml](template.yaml).

![Architecture](/img/architecture.png)

As the example applications, the template deploys three applications which are Default, App1 and App2 and they can be accessed through the paths `/`, `/app1` and `/app2` respectively.
ALB takes case of forwarding the request to those application based on its path and it is set as a target of NLB which has two static IP addresses (In this example, `10.0.10.30` and `10.0.11.30`)

# Sample Application
The sample application can be built by the following commnad. The image need to be pushed on container repository like ECR and can be pulled by ECS.
The image URL should be provided as the CloudFormation parameter `AppImageUrl`

```shell
$ cd app
$ docker build -t sample-app .
```

# Confirm path-based routing
Once the sample application is deployed, it can be confirmed by accessing NLB. NLB should be accessed from within the VPC because it's configured as a internal load balancer.  
You can launch EC2 instance in the VPC and access the NLB through the IP addresses `10.0.10.30` or `10.0.11.30`.

```shell
$ curl -L 10.0.10.30/app1
app1
$ curl -L 10.0.10.30/app2
app2
$ curl -L 10.0.11.30/app1
app1
$ curl -L 10.0.11.30/app2
app2
```

# Clean up
To clean up the application, delete the CloudFormation stack.