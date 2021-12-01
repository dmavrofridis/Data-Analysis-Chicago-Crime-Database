# Main File for NLP
import pandas as pd
import numpy as np
import psycopg2
from global_variables import *
import bertopic
from copy import deepcopy
from bertopic import BERTopic
import nltk
from nltk.corpus import stopwords

nltk.download('stopwords')


def topics_per_race(race, df):
    return df.loc[df['race'] == race]['topics'].value_counts()


def topics_per_community(community, df):
    return df.loc[df['community'] == community]['topics'].value_counts()


def connect_to_db():
    return psycopg2.connect(conn_string)


def query_to_string():
    # Open and read the file as a single buffer
    fd = open(sql_file, 'r')
    sqlFile = fd.read()
    fd.close()
    return sqlFile


def clean_df_strings(df, column):
    stop_words = stopwords.words('english')
    stop_words += custom_stop_words + custom_punctuation
    df[column] = df[column].apply(lambda x: ' '.join([word for word in x.split() if word.lower().isalnum()]))
    df[column] = df[column].apply(lambda x: ' '.join([word for word in x.split() if word.lower() not in (stop_words)]))
    return df


def generate_topics(docs, model):
    # docs = list(filter("".__ne__, docs))
    # docs = list(filter(None.__ne__, docs))

    # create model
    if model is None:
        model = BERTopic(language="english", calculate_probabilities=True, verbose=True)

    topics, probabilities = model.fit_transform(docs)
    info = model.get_topic_info()
    freq = model.get_topic_freq()
    print("\n")
    print(info)
    print("\n")
    for i in range(len(freq)):
        print(model.get_topic(i))

    model.visualize_topics(top_n_topics=5)
    model.visualize_barchart(top_n_topics=5)

    # Save the model
    model.save("model")

    return topics, probabilities


if __name__ == '__main__':
    connection = connect_to_db()
    sql_query = query_to_string()
    # First step is to import the required tables
    df = pd.read_sql(sql_query, connection)
    df.name = "cp5"
    model = None
    print(df.shape)

    # Before loading the model, we make sure to remove the stopwords and clean the
    # strings
    print("BEFORE -> ", df['cr_text'].tolist()[0])
    df = clean_df_strings(df, "cr_text")
    print("\nAFTER -> ", df['cr_text'].tolist()[0])

    try:
        model = BERTopic.load("model")
        print("Model exists, loading it now!")
    except:
        print("Model does not exist yet, train it now!")

    topics, probabilities = generate_topics(df['cr_text'].tolist(), model)
    df["topics"] = topics

    for race in unique_races:
        print("\nCount of topics for race -> ", race)
        topic_count = topics_per_race(race, df)
        print(topic_count)

    for community in unique_communities:
        print("\nCount of topics for community -> ", community)
        topic_count = topics_per_community(community, df)
        print(topic_count)