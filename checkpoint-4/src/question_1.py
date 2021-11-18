# SPARK or Graph X

from pyspark import *
from pyspark.sql import *
from graphframes import *
import findspark
import pandas
import psycopg2
from global_variables import *


def main():
    # conn = psycopg2.connect(host=sql_host, port=sql_port, database=sql_database, user=sql_user, password=sql_password)
    # cursor = conn.cursor()

    findspark.init()
    spark_conf = SparkConf().setMaster("local[*]").setAppName("IT WORKS")
    spark = SparkSession.builder.config(conf=spark_conf).getOrCreate()

    vertices = spark.createDataFrame([
        ("a", "Alice", 34),
        ("b", "Bob", 36),
        ("c", "Charlie", 30),
        ("d", "David", 29),
        ("e", "Esther", 32),
        ("f", "Fanny", 36),
        ("g", "Gabby", 60)], ["id", "name", "age"])

    edges = spark.createDataFrame([
        ("a", "b", "friend"),
        ("b", "c", "follow"),
        ("c", "b", "follow"),
        ("f", "c", "follow"),
        ("e", "f", "follow"),
        ("e", "d", "friend"),
        ("d", "a", "friend"),
        ("a", "e", "friend")
    ], ["src", "dst", "relationship"])

    g = GraphFrame(vertices, edges)

    g.vertices.show()

if __name__ == "__main__":
    main()