☁️ What is AWS CloudFormation?
AWS CloudFormation is an IaC service from AWS that lets you define your infrastructure in YAML or JSON format. Using CloudFormation, you can automate the creation, update, and deletion of AWS resources in a repeatable and safe manner.

| Concept        | Description                                                           |
| -------------- | --------------------------------------------------------------------- |
| **Template**   | A YAML/JSON file that defines AWS resources and configuration         |
| **Stack**      | A deployed instance of a CloudFormation template                      |
| **StackSet**   | Manages stacks across multiple accounts/regions                       |
| **Resources**  | The actual AWS services (EC2, S3, RDS, etc.) declared in the template |
| **Parameters** | Input values passed during stack creation                             |
| **Outputs**    | Export key values (e.g., IP, URL) from the stack                      |
| **Conditions** | Control resource creation based on conditions                         |
| **Mappings**   | Hard-coded values (like region to AMI ID mappings)                    |
| **Metadata**   | Extra data to annotate resources                                      |

🧪 Sample CloudFormation Template (YAML)

AWSTemplateFormatVersion: '2010-09-09'
Description: Simple EC2 instance

Parameters:
  KeyName:
    Description: EC2 KeyPair
    Type: AWS::EC2::KeyPair::KeyName

Resources:
  MyInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0abcdef1234567890
      InstanceType: t2.micro
      KeyName: !Ref KeyName
      Tags:
        - Key: Name
          Value: MyEC2Instance

Outputs:
  InstanceId:
    Description: EC2 Instance ID
    Value: !Ref MyInstance
