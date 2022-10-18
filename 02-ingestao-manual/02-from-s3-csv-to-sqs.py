from util.S3Handler import S3ClientHandler
from util.SQSHandler import SQSHandler


def main():

    s3 = S3ClientHandler()
    sqs = SQSHandler()

    BUCKET = 's3-fiap-grupo-o'
    BUCKET_KEY = 'small-files/'
    SQS_URL = 'https://sqs.us-east-1.amazonaws.com/890480273214/small_files_csv'

    listObjectKeys = s3.getListOfKeyObjects(BUCKET, BUCKET_KEY)

    listOfLists = sqs.mountMessagesToSQS(listObjectKeys)

    for listToSend in listOfLists:
        sqs.sendToQueue(SQS_URL, listToSend)


if __name__ == '__main__':
    main()
