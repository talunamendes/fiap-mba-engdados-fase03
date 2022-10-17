import uuid

import boto3
import json


class SQSHandler:

    def __init__(self):
        self.sqs = boto3.client('sqs')

    def getMessageFromQueue(self, sqs_url):
        response = self.sqs.receive_message(
            QueueUrl=sqs_url,
            MaxNumberOfMessages=1
        )
        print(json.dumps(response))
        if "Messages" in response:
            receiptHandle = response["Messages"][0]["ReceiptHandle"]
            message = response["Messages"][0]["Body"]
            return receiptHandle, message
        else:
            return None, None

    def deleteMessageFromQueue(self, sqs_url, receiptHandle):
        response = self.sqs.delete_message(
            QueueUrl=sqs_url,
            ReceiptHandle=receiptHandle
        )
        print(json.dumps(response))

    @staticmethod
    def mountMessagesToSQS(listObjectKeys, numberMsgsByBatch=10):
        listEntriesSQS = []
        for obj in listObjectKeys:
            listEntriesSQS.append(
                {
                    "Id": str(uuid.uuid1()),
                    'MessageBody': json.dumps(obj)
                }
            )
        listOfLists = [listEntriesSQS[i * numberMsgsByBatch:(i + 1) * numberMsgsByBatch]
                       for i in range((len(listEntriesSQS) + numberMsgsByBatch - 1) // numberMsgsByBatch)]
        return listOfLists

    def sendToQueue(self, sqs_url, listToSend):
        response = self.sqs.send_message_batch(
            QueueUrl=sqs_url,
            Entries=listToSend
        )
        print(response)
