import boto3


class S3ClientHandler:

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


class S3ObjectHandler:

    def __init__(self, bucket, key):
        self.s3 = boto3.resource('s3')
        self.s3Object = self.s3.Object(bucket, key)

    def getStreamingBody(self):
        return self.s3Object.get()['Body']._raw_stream

    def put(self, file):
        self.s3Object.put(Body=file)
