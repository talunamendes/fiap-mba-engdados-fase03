import csv
import json
from io import StringIO
import uuid

from util.SQSHandler import SQSHandler
from util.S3Handler import S3ObjectHandler


def createJsonFromCSVInS3(bucket, key):
    COLUMNS = ["BibNum", "Title", "Author",
               "ISBN", "PublicationYear", "Publisher", "Publisher",
               "Subjects", "ItemType", "ItemCollection", "FloatingItem",
               "ItemLocation", "ReportDate", "ItemCount"]

    csvObj = S3ObjectHandler(bucket, key)

    listRows = []

    # countLine = 1
    for line in csvObj.getStreamingBody():
        s = StringIO(line.decode("utf-8"))
        linha = csv.reader(s, skipinitialspace=True)

        for row in linha:
            data = {}
            # print("linha: "+str(countLine))
            data["id"] = str(uuid.uuid4())
            for i in range(len(COLUMNS) - 1):
                # print("coluna: " + str(i))
                data[COLUMNS[i]] = row[i]

            listRows.append(data)
            # countLine += 1

    fileContent = ""
    escapeChar = "\n"
    for row in listRows:
        fileContent += json.dumps(row)
        fileContent += escapeChar

    removal = escapeChar
    reverse_removal = removal[::-1]

    replacement = ""
    reverse_replacement = replacement[::-1]
    fileContent = fileContent[::-1].replace(reverse_removal,
                                            reverse_replacement, 1)[::-1]
    filename = key.split("/")[1] + ".json"
    print(filename)

    jsonObj = S3ObjectHandler(bucket, "json/" + filename)
    jsonObj.put(fileContent.encode())


def main():
    URL_SQS = 'https://sqs.us-east-1.amazonaws.com/890480273214/small_files_csv'

    sqs = SQSHandler()

    while True:
        receiptHandle, messageStr = sqs.getMessageFromQueue(URL_SQS)
        if receiptHandle is None:
            print("nada")
            break
        else:
            print(messageStr)
            message = json.loads(messageStr)
            createJsonFromCSVInS3(message["bucket"], message["key"])
            sqs.deleteMessageFromQueue(URL_SQS, receiptHandle)


if __name__ == '__main__':
    main()
