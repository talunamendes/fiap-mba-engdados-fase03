from util.KinesisHandler import KinesisHandler
from util.S3Handler import S3ObjectHandler
from util.SQSHandler import SQSHandler


def readObjectAndSendToFirehose(bucket, bucket_key, kinesis_name):
    kinesis = KinesisHandler(kinesis_name)
    jsonObj = S3ObjectHandler(bucket, bucket_key)
    cont = 0
    listLines = []
    for line in jsonObj.getStreamingBody():
        # s = StringIO(line.decode("utf-8"))
        listLines.append(line.decode("utf-8"))
        if cont == 149:
            kinesis.put_record(listLines)
            cont = 0
            listLines = []
        else:
            cont += 1
    if len(listLines) > 0:
        kinesis.put_record(listLines)
        print("enviou fora for")


def main():
    sqs = SQSHandler()
    URL_SQS = 'https://sqs.us-east-1.amazonaws.com/890480273214/raw_json'
    kinesis_name = 'ingest-json'

    while True:
        receiptHandle, message = sqs.getMessageFromQueue(URL_SQS)
        if receiptHandle is None:
            print("acabou a fila")
            break
        else:
            print("received message: " + str(message))
            bucket = message["bucket"]
            key = message["key"]
            readObjectAndSendToFirehose(bucket, key, kinesis_name)
            sqs.deleteMessageFromQueue(URL_SQS, receiptHandle)

    print("terminou com sucesso")


if __name__ == '__main__':
    main()
