# SPARK or Graph X
from pyspark import *
from pyspark.sql import *
import pandas as pd
import findspark
import os


if __name__ == '__main__':
    os.environ["JAVA_HOME"] = "./packages/adoptopenjdk-8.jdk"
    os.environ["SPARK_HOME"] = "./packages/spark-3.2.0-bin-hadoop3.2"

    findspark.init()
    # start the session
    spark = SparkSession.builder.master("local[*]").getOrCreate()

from pyspark import *
from pyspark.sql import *
from graphframes import *
import findspark
import pandas
import psycopg2
from global_variables import *


def main():
    conn = psycopg2.connect(host=sql_host, port=sql_host, database=sql_database, user=sql_user, password=sql_password)
    cursor = conn.cursor()

if __name__ == "__main__":
    main()