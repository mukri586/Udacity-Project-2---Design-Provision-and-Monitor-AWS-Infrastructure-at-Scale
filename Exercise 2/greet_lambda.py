import os

def lambda_handler(event, context):
	print ("my file uploaded successfully")
    return "{} from Lambda!".format(os.environ['greeting'])
