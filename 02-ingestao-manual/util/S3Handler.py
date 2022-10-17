import boto3


class S3Handler:

    def __init__(self):
        self.s3 = boto3.client('s3')

    def getListOfKeyObjects(self, bucket, keyPrefix):
        response = self.s3.list_objects_v2(
            Bucket=bucket,
            Prefix=keyPrefix
        )

        listObjectKeys = []
        for obj in response["Contents"]:
            listObjectKeys.append({"bucket": bucket, "key": obj["Key"]})
            # print(obj["Key"])
        print(len(listObjectKeys))
        # print(response)
        return listObjectKeys
