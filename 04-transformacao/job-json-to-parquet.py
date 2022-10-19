import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node Amazon S3 - JSON
AmazonS3JSON_node1666144223184 = glueContext.create_dynamic_frame.from_options(
    format_options={"multiline": False},
    connection_type="s3",
    format="json",
    connection_options={
        "paths": ["s3://s3-fiap-grupo-o/ingested-json/"],
        "recurse": True,
    },
    transformation_ctx="AmazonS3JSON_node1666144223184",
)

# Script generated for node Amazon S3 - Parquet
AmazonS3Parquet_node1666144329387 = glueContext.getSink(
    path="s3://s3-fiap-grupo-o/parquet/",
    connection_type="s3",
    updateBehavior="UPDATE_IN_DATABASE",
    partitionKeys=["id"],
    enableUpdateCatalog=True,
    transformation_ctx="AmazonS3Parquet_node1666144329387",
)
AmazonS3Parquet_node1666144329387.setCatalogInfo(
    catalogDatabase="fiap-grupo-o", catalogTableName="parquet"
)
AmazonS3Parquet_node1666144329387.setFormat("glueparquet")
AmazonS3Parquet_node1666144329387.writeFrame(AmazonS3JSON_node1666144223184)
job.commit()
