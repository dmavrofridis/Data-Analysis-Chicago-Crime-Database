# Main File for NLP
import pandas as pd
import numpy as np
import psycopg2
import bertopic
from copy import deepcopy
from bertopic import BERTopic

from global_variables import *


def connect_to_db():
    return psycopg2.connect(conn_string)


def query_to_string():
    # Open and read the file as a single buffer
    fd = open(sql_file, 'r')
    sqlFile = fd.read()
    fd.close()
    return sqlFile


def generate_topics(docs, model):

    docs = list(filter("".__ne__, docs))
    docs = list(filter(None.__ne__, docs))

    # create model
    if model is None:
        model = BERTopic(language="english", calculate_probabilities=True, verbose=True)

    topics, probs = model.fit_transform(docs)
    info = model.get_topic_info()
    freq = model.get_topic_freq()
    print(freq)

    for i in range(len(freq)):
        print(model.get_topic(i))

    model.visualize_topics()
    model.visualize_barchart()
    # Save the model
    model.save("my_topics_model")


if __name__ == '__main__':
    connection = connect_to_db()
    sql_query = query_to_string()
    # First step is to import the required tables
    df = pd.read_sql(sql_query, connection)
    df.name = "cp5"
    model = None
    try:
        model = BERTopic.load("my_topics_model")
        print("Model exists, loading it now!")
    except:
        print("Model does not exist yet, train it now!")

    generate_topics(df['cr_text'].tolist(), model)
