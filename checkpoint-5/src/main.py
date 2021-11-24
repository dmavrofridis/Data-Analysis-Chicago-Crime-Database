# Main File for NLP
import pandas as pd
import psycopg2
from global_variables import *


def connect_to_db():
    return psycopg2.connect(conn_string)


def query_to_string():
    # Open and read the file as a single buffer
    fd = open('cp5_query.sql', 'r')
    sqlFile = fd.read()
    fd.close()
    return sqlFile


if __name__ == '__main__':
    connection = connect_to_db()
    sql_query = query_to_string()
    # First step is to import the required tables
    df = pd.read_sql(sql_query, connection)
    df.name = "cp5"
