#!/bin/bash -ex

pushd modules
rm modules.zip || rm ../modules.zip || true
zip modules.zip *
mv modules.zip ..
popd
/usr/local/spark/bin/spark-submit --driver-memory 10g --executor-memory 6g --master spark://ec2-3-219-180-255.compute-1.amazonaws.com:7077 --packages  com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.3 --driver-class-path  /usr/local/spark/jars/postgresql-42.2.13.jar --jars /usr/local/spark/jars/postgresql-42.2.13.jar --py-files modules.zip process_monthly_data.py --year 2019 --month 12 --s3_bucket "s3a://reddit-data-parquet/"
