from aws_lambda_powertools.event_handler import APIGatewayHttpResolver # Use HttpResolver for API GW v2
import boto3

# Initialize DynamoDB
dynamodb = boto3.resource('dynamodb')
# Best practice: Use environment variables for table names
users_table = dynamodb.Table('users')


app = APIGatewayHttpResolver()

@app.get("/users/<id>")
def user_details(id: str):
    response = users_table.get_item(Key={'id': id})
    item = response.get('Item', {"error": "User not found"})
    return {"message": item}

@app.post("/users")
def create_user():
    # Powertools handles the JSON parsing from API Gateway event automatically
    user_data = app.current_event.json_body
    users_table.put_item(Item=user_data)
    return {"message": "User created successfully"}

@app.get("/users")
def get_users():
    response = users_table.scan()
    return {"message": response.get('Items', [])}

@app.get("/hii")
def greet_hii():
    return {"message": "Hii, World!"}


@app.get("/hello")
def greet_hello():
    return {"message": "Hello, World!"}  

# The handler remains the same, but 'app' is now an API Gateway resolver
def handler(event, context):
    try:
        return app.resolve(event, context)
    except Exception as e:
        print(e)
        raise e