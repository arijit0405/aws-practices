![image](https://github.com/user-attachments/assets/5f4db2b3-63c6-48cf-915b-6250cd8206b7)

AWS Lambda EBS Snapshot Cleanup Project
This document outlines the step-by-step process of a project involving the creation of an AWS EC2 instance, EBS volume, snapshot, and a Lambda function to automatically delete unattached EBS snapshots.
Step 1: Created an EC2 Instance

Launched an Amazon EC2 instance using the AWS Management Console or CLI.
By default, an EBS volume was automatically attached to the EC2 instance as its root volume during creation.

Step 2: Created an EBS Snapshot

Created a snapshot of the EBS volume attached to the EC2 instance.
The snapshot was stored in Amazon EBS, capturing the state of the volume at the time of creation.

Step 3: Deleted the EC2 Instance

Terminated the EC2 instance, which automatically deleted the attached EBS volume (as per default behavior when the volume is set to delete on termination).
The snapshot created in Step 2 remained in EBS storage, as snapshots are independent of the volume or instance.

Step 4: Developed a Lambda Function for Snapshot Cleanup

Created an AWS Lambda function to automatically delete EBS snapshots that are not associated with any existing volume or whose volume is not attached to a running EC2 instance.
Used Python and the AWS SDK (boto3) to interact with AWS EC2 services.
The Lambda function performs the following actions:
Retrieve Snapshots: Queries all EBS snapshots owned by the AWS account using describe_snapshots.
Identify Running Instances: Retrieves a list of running EC2 instances using describe_instances to determine active instance IDs.
Check Snapshot Status:
If a snapshot is not associated with any volume (no VolumeId), it is deleted.
If a snapshot is associated with a volume, checks if the volume exists using describe_volumes.
If the volume exists but is not attached to any running instance (no attachments), the snapshot is deleted.
If the volume does not exist (e.g., deleted), the snapshot is deleted.


Delete Snapshots: Uses delete_snapshot to remove snapshots that meet the deletion criteria.
Logs the deletion actions with print statements for monitoring.



Step 5: Lambda Function Code
The Python code for the Lambda function is as follows:
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')

    # Get all EBS snapshots
    response = ec2.describe_snapshots(OwnerIds=['self'])

    # Get all active EC2 instance IDs
    instances_response = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    active_instance_ids = set()

    for reservation in instances_response['Reservations']:
        for instance in reservation['Instances']:
            active_instance_ids.add(instance['InstanceId'])

    # Iterate through each snapshot and delete if it's not attached to any volume or the volume is not attached to a running instance
    for snapshot in response['Snapshots']:
        snapshot_id = snapshot['SnapshotId']
        volume_id = snapshot.get('VolumeId')

        if not volume_id:
            # Delete the snapshot if it's not attached to any volume
            ec2.delete_snapshot(SnapshotId=snapshot_id)
            print(f"Deleted EBS snapshot {snapshot_id} as it was not attached to any volume.")
        else:
            # Check if the volume still exists
            try:
                volume_response = ec2.describe_volumes(VolumeIds=[volume_id])
                if not volume_response['Volumes'][0]['Attachments']:
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f"Deleted EBS snapshot {snapshot_id} as it was taken from a volume not attached to any running instance.")
            except ec2.exceptions.ClientError as e:
                if e.response['Error']['Code'] == 'InvalidVolume.NotFound':
                    # The volume associated with the snapshot is not found (it might have been deleted)
                    ec2.delete_snapshot(SnapshotId=snapshot_id)
                    print(f"Deleted EBS snapshot {snapshot_id} as its associated volume was not found.")

Step 6: Tested the Lambda Function

Deployed the Lambda function in the AWS Lambda console.
Executed the function to ensure it correctly identifies and deletes unattached or orphaned EBS snapshots.
Verified the logs (via print statements) in Amazon CloudWatch to confirm successful deletion of snapshots.

Step 7: Automation and Monitoring

Configured the Lambda function to run on a schedule (e.g., using Amazon EventBridge) to periodically check for and delete unattached snapshots.
Monitored the function’s performance and snapshot deletions via CloudWatch logs to ensure it operates as expected.

Summary
This project demonstrates the use of AWS services (EC2, EBS, Lambda) to manage cloud resources efficiently. By automating the cleanup of unattached EBS snapshots, the solution helps reduce storage costs and maintain a tidy AWS environment.

