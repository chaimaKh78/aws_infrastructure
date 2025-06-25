import boto3
import datetime

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    today = datetime.datetime.utcnow()
    retention_days = 7
    print("Getting active volumes...")
    volumes_in_use = set()
    volumes = ec2.describe_volumes(
        Filters=[
            {"Name": "status", "Values": ["in-use"]}
        ]
    )["Volumes"]

    for vol in volumes:
        volumes_in_use.add(vol["VolumeId"])

    print(f"Active volumes: {volumes_in_use}")

    print("Checking all snapshots...")
    snapshots = ec2.describe_snapshots(OwnerIds=["self"])["Snapshots"]

    for snap in snapshots:
        start_time = snap["StartTime"].replace(tzinfo=None)
        age = (today - start_time).days
        volume_id = snap.get("VolumeId")

        if age <= retention_days:
            continue

        if volume_id in volumes_in_use:
            continue

        tags = {t["Key"]: t["Value"] for t in snap.get("Tags", [])}
        if tags.get("BackupPolicy") == "daily":
            print(f"Deleting unused snapshot: {snap['SnapshotId']} (VolumeId: {volume_id}, age: {age} days)")
            ec2.delete_snapshot(SnapshotId=snap["SnapshotId"])
