import tensorflow as tf
import pickle
from tensorflow.keras.preprocessing.sequence import pad_sequences
import contractions
import re
import nltk
from nltk.stem import WordNetLemmatizer
import numpy as np

VOCAB_SIZE = 20000
BATCH_SIZE = 256
EMBEDDING_DIM = 256
MAX_LENGTH = 40
trunc_type = 'post'
padding_type = 'post'
oov_token = '<OOV>'

with open('./tokenizer.pickle', 'rb') as f:
    tokenizer = pickle.load(f)

model = tf.keras.Sequential([
    tf.keras.layers.Embedding(
        VOCAB_SIZE, EMBEDDING_DIM, input_length=MAX_LENGTH),
    tf.keras.layers.Bidirectional(tf.keras.layers.LSTM(
        128, recurrent_dropout=0.3, dropout=0.3, return_sequences=False, unit_forget_bias=True, implementation=2)),
    tf.keras.layers.Dense(24, activation='relu'),
    tf.keras.layers.Dense(1, activation='sigmoid')
])
model.compile(loss='binary_crossentropy',
              optimizer='adam', metrics=['accuracy'])
model.load_weights('./weights/model_weights3.h5')


def clean_contraction_mapping(text):
    expanded_words = []
    for word in text.split():
        expanded_words.append(contractions.fix(word))
    expanded_text = ' '.join(expanded_words)
    return expanded_text


def clean(text):
    text = clean_contraction_mapping(text)
    text = re.sub('[^a-zA-Z]', " ", text)
    text = text.lower()
    text = text.split()
    lem = WordNetLemmatizer()
    text = [lem.lemmatize(word) for word in text]
    return " ".join(text)


def predict(sentence: str):
    clean_sentence = [clean(sentence)]
    sequences = tokenizer.texts_to_sequences(clean_sentence)
    padded = pad_sequences(sequences, maxlen=MAX_LENGTH,
                           padding=padding_type, truncating=trunc_type)
    out = (model.predict(padded))
    return out[0][0]


if __name__ == "__main__":
    sentence = 'Wow, I just love standing in line for hours to see a mediocre attraction. What a fantastic use of my vacation time!'
    print(predict(sentence))
