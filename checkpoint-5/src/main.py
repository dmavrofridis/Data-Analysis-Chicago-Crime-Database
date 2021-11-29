# Main File for NLP
import pandas as pd
import psycopg2
import bertopic
from global_variables import *


def connect_to_db():
    return psycopg2.connect(conn_string)


def query_to_string():
    # Open and read the file as a single buffer
    fd = open(sql_file, 'r')
    sqlFile = fd.read()
    fd.close()
    return sqlFile

def generate_topics(docs):
    docs = list(filter(("").__ne__, docs))
    docs = list(filter((None).__ne__, docs))
    topic_model = bertopic.BERTopic(language="english", calculate_probabilities=True, verbose=True)
    topics, probs = topic_model.fit_transform(docs)

    freq = topic_model.get_topic_info()

    print(freq)

    for i in range(len(freq)):
        print(topic_model.get_topic(i))

if __name__ == '__main__':
    connection = connect_to_db()
    sql_query = query_to_string()
    # First step is to import the required tables
    df = pd.read_sql(sql_query, connection)
    df.name = "cp5"

    generate_topics(df['cr_text'].tolist())
