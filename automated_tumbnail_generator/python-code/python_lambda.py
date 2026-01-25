import json

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
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
