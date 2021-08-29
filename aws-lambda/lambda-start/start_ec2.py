import boto3
ec2 = boto3.resource('ec2')
def lambda_handler(event, context):
    filters = [{'Name': 'tag-key', 'Values': ['Desliga']}]
    ec2.instances.filter(Filters=filters).start()