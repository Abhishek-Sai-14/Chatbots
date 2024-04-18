# Importing necessary libraries
import nltk
from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np
from flask import Flask, redirect, url_for, request, render_template
from keras.models import load_model
import json
import random
from translate import Translator

# Load trained chatbot model and data
model = load_model('chatbot_model.h5')  # Load pre-trained chatbot model
intents = json.loads(open('intents (1).json').read())  # Load intent data from JSON file
words = pickle.load(open('words.pkl','rb'))  # Load preprocessed words
classes = pickle.load(open('classes.pkl','rb'))  # Load intent classes

# Function to perform language translation
def translate_text(text, target_language):
    translator = Translator(to_lang=target_language)  # Initialize translator
    translation = translator.translate(text)  # Translate text
    return translation  # Return translated text

# Function to clean up and lemmatize input sentence
def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)  # Tokenize input sentence
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]  # Lemmatize words
    return sentence_words  # Return cleaned and lemmatized words

# Function to create bag of words
def bow(sentence, words, show_details=True):
    sentence_words = clean_up_sentence(sentence)  # Clean and lemmatize sentence
    bag = [0]*len(words)  # Initialize bag of words
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                bag[i] = 1  # Mark word as present in bag
                if show_details:
                    print ("found in bag: %s" % w)  # Print word found in bag
    return(np.array(bag))  # Return bag of words as numpy array

# Function to predict intent
def predict_class(sentence, model):
    p = bow(sentence, words, show_details=False)  # Get bag of words
    res = model.predict(np.array([p]))[0]  # Predict intent
    ERROR_THRESHOLD = 0.25  # Set error threshold
    results = [[i,r] for i,r in enumerate(res) if r>ERROR_THRESHOLD]  # Filter predictions
    results.sort(key=lambda x: x[1], reverse=True)  # Sort predictions by probability
    return_list = []
    for r in results:
        return_list.append({"intent": classes[r[0]], "probability": str(r[1])})  # Append intent and probability to return list
    return return_list  # Return list of predicted intents

# Function to get response based on predicted intent
def getResponse(ints, intents_json):
    tag = ints[0]['intent']  # Get predicted intent tag
    list_of_intents = intents_json  # Get list of all intents
    for i in list_of_intents:
        if i['tag'] == tag:
            result = random.choice(i['responses'])  # Select random response from matched intent
            break
    return result  # Return selected response

# Function to get chatbot response
def chatbot_response(msg):
    ints = predict_class(msg, model)  # Get predicted intent
    res = getResponse(ints, intents)  # Get response based on predicted intent
    return res  # Return chatbot response

# Initialize Flask app
app = Flask(__name__)  # Create Flask app instance
app.static_folder = 'C:\\Users\\Abhi Manohar\\OneDrive\\Desktop\\chatbot-python-project-data-codes\\static\\'  # Set static folder path

# Define routes for Flask app

# Home page route
@app.route('/', methods=['GET','POST'])
def home():
    if request.method == 'POST':
        if "a" in request.form:
            return redirect(url_for('userpage1'))  # Redirect to userpage1
        if "b" in request.form:
            return redirect(url_for('adminpage1'))  # Redirect to adminpage1
    return render_template("index.html")  # Render home page template

# User page routes
@app.route("/userpage1", methods=['GET','POST'])
def userpage1():
    if request.method == 'POST':
        if "a1" in request.form:
            return redirect(url_for('userpage2'))  # Redirect to userpage2
    return render_template("userpage1.html")  # Render userpage1 template

@app.route("/userpage2", methods=["GET"])
def userpage2():
    return render_template("userpage2.html")  # Render userpage2 template

# Admin page routes
@app.route("/adminpage1", methods=['GET','POST'])
def adminpage1():
    if request.method == 'POST':
        if "a1" in request.form:
            return redirect(url_for('adminpage2'))  # Redirect to adminpage2
    return render_template("adminpage1.html")  # Render adminpage1 template

@app.route("/adminpage2", methods=['GET','POST'])
def adminpage2():
    if request.method == 'POST':
        if "a1" in request.form:
            return redirect(url_for('hotel'))  # Redirect to hotel
    return render_template("adminpage2.html")  # Render adminpage2 template

@app.route("/hotel", methods=["GET"])
def hotel():
    return render_template("hotel.html")  # Render hotel template

# Bot response route
@app.route("/get")
def get_bot_response():
    userText = request.args.get('msg')  # Get user input text
    translator = Translator(to_lang='en', from_lang='te')  # Initialize translator
    translation = translator.translate(userText)  # Translate user input
    bot_response = chatbot_response(translation)  # Get chatbot response
    translated_bot_response = translate_text(bot_response, 'te')  # Translate chatbot response
    return translated_bot_response  # Return translated chatbot response

if __name__ == "__main__":
    app.run()  # Run Flask app
