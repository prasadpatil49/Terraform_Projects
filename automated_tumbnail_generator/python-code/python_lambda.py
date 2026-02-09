import json
import boto3

def lambda_handler(event, context):
    """
    This function demonstrates a basic AWS Lambda handler.
    
    :param event: The event object containing data for the function to process.
    :param context: The context object providing information about the invocation.
    :return: A dictionary with status code and body.
    """
    # Log the event data to Amazon CloudWatch
    print("Received event: " + json.dumps(event, indent=2))

    # Return a response object
    # get the bucket name and object key from the event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']
    print(f"Bucket name: {bucket_name}")
    print(f"Object key: {object_key}")
    # get the image from the s3 bucket
    # generate the thumbnail
    # move the image to the thumbnails folder
    s3 = boto3.client('s3')
    response = s3.copy_object(
        Bucket=bucket_name,
        Key=f'thumbnails/thumbnail_{object_key.split("/")[-1]}',
        CopySource={
            'Bucket': bucket_name,
            'Key': object_key
        }

    )
    # delete the original image if moved successfully
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print(f"Moved image to thumbnails folder: {object_key}")
        s3.delete_object(
            Bucket=bucket_name,
            Key=object_key
        )

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
