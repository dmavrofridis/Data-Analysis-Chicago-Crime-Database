# SPARK or Graph X

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