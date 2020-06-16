from flask import Flask,jsonify

app = Flask(__name__)

@app.route('/')
def main():
    return "Welcome to memroAi"

#add api calls here.start with '/api'

if __name__ == '__app__':
    app.run(port=5000) 