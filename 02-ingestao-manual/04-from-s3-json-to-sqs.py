from util.S3Handler import S3ClientHandler
from util.SQSHandler import SQSHandler


# TODO melhorar o codigo para reaproveitar o que foi feito no 02-from-s3-csv-to-sqs
# TODO deixamos dessa forma por efeito de celeridade da entrega do trabalho

def main():
    s3 = S3ClientHandler()
    sqs = SQSHandler()

    BUCKET = 's3-fiap-grupo-o'
    BUCKET_KEY = 'json/'
    SQS_URL = 'https://sqs.us-east-1.amazonaws.com/890480273214/raw_json'

    listObjectKeys = s3.getListOfKeyObjects(BUCKET, BUCKET_KEY)

    listOfLists = sqs.mountMessagesToSQS(listObjectKeys)

    for listToSend in listOfLists:
        sqs.sendToQueue(SQS_URL, listToSend)


if __name__ == '__main__':
    main()
