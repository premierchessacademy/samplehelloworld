import json

def lambda_handler(event, context):
    print(event)
    # TODO implement
    print(" We will try to add new lines 12")


    return {
        'statusCode': 200,
        'body': json.dumps(' Trial Run')
    }

