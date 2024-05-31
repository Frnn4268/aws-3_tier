# **Description Three-tier architecture AWS**

![GitHub stars](https://img.shields.io/github/stars/Frnn4268/AWS-3_Tier.svg)
![GitHub forks](https://img.shields.io/github/forks/Frnn4268/AWS-3_Tier.svg)
![GitHub issues](https://img.shields.io/github/issues/Frnn4268/AWS-3_Tier.svg)

The 3-layer (3-tier) architecture in AWS is a design model that separates an application into three distinct logical layers: the presentation layer, the business logic layer, and the data layer. This modular approach allows for greater scalability, flexibility and system management, facilitating maintenance and continuous improvement. This describes how a 3-layer architecture is implemented in AWS.

**1. Presentation Layer (Frontend)**
The presentation layer is the user interface of the application, responsible for interaction with end users. In a 3-layer AWS architecture, this layer is implemented using:

- Amazon S3: Stores and serves static frontend files (HTML, CSS, JavaScript, images, etc.).
- Amazon CloudFront: Distributes content stored in S3 through a content distribution network (CDN), improving access speed and user experience.
- Amazon Route 53: Manage DNS to drive user traffic to CloudFront.

**2. Business Logic Layer (Backend)**
The business logic layer handles data processing and business rules. This layer is implemented using:

- Amazon EC2: Server instances that host the business logic of the application, running the backend, as a RESTful API.
- Auto Scaling Group: Ensures that the number of EC2 instances can scale automatically on demand.
- Elastic Load Balancer (ELB): Distributes incoming traffic between EC2 instances to ensure high availability and scalability.

**3. Layer of Data**
The data layer handles data storage, retrieval and management. In AWS, this layer can be implemented using:

- Amazon RDS: Managed relational database (such as MySQL, PostgreSQL) that handles structured data.
- Amazon DynamoDB: NoSQL database for unstructured and high availability data.
- Amazon S3: For storing objects, such as large files and backups.
- Amazon ElastiCache: Memory cache (Redis or Memcached) to speed access to frequently consulted data.

**Integration and Security**
- Amazon VPC: Provides an isolated network where AWS resources run, ensuring a secure and managed environment.
- Security Groups and NACLs: Control incoming and outgoing traffic at the instance and subnet levels, respectively, ensuring data and application security.
- AWS IAM: Manages access and security policies for AWS resources.
- Advantages of 3 Layer Architecture in AWS
- Scalability: Each layer can scale independently on demand, improving efficiency and performance.
- High availability: AWS offers managed services and load distribution to minimize downtime.
- Security: Layer segregation along with AWS security services provides a secure environment for application and data.
- Maintenance and development: The modularity of the architecture facilitates the maintenance and development of new functionalities without affecting the entire system.

## Three-tier architecture overview 

![Architecture](https://drive.google.com/uc?export=download&id=1pwYPIxjG6gxny-YmR1pCGrTABTJXdKCR)

### Prerequisites
- Create a secret containing a username and password with corresponding values using the AWS Secrets Manager. You can refer to this sample JSON template that contains the secret name 
	> ams-shared/myapp/dev/dbsecrets

	and replace it with your secret name. For information about using AWS Secrets Manager with AMS, see Using AWS Secrets Manager with AMS resources.

- Set up required parameters in the AWS SSM Parameter Store (PS). In this example, the VPCId and Subnet-Id of the Private and Public subnets are stored in the SSM PS in paths like
	> /app/DemoApp/PublicSubnet1a, PublicSubnet1c PrivateSubnet1a

	PrivateSubnet1c and VPCCidr. Update the paths and parameter names and values for your needs.

- Create an IAM Amazon EC2 instance role with read permissions to the AWS Secrets Manager and SSM Parameter Store paths (the IAM role created and used in these examples is 

	> customer-ec2_secrets_manager_instance_profile).

	If you create IAM-standard policies like instance profile role, the role name must start with customer-. To create a new IAM role, 
	>(you can name it customer-ec2_secrets_manager_instance_profile, or something else) 

	use the AMS change type Management | Applications | IAM instance profile | Create (ct-0ixp4ch2tiu04) CT, and attach the required policies. You can review the AMS IAM standard policies,

	>	customer_secrets_manager_policy 

	and

	>customer_systemsmanager_parameterstore_policy, in the AWS IAM console to be used as-is or as a reference.
