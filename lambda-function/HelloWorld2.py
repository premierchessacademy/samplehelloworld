import json

def lambda_handler(event, context):
    print(event)
    # TODO implement
    print(" We will try to add new lines 12")
    print("Afsal commit")


    return {
        'statusCode': 200,
        'body': json.dumps('{"key1":"value1","key2":200}')
    }