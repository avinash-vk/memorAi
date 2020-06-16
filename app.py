from flask import Flask

app = Flask(__name__)

@app.route('/')
def main():
    return "Welcome to memroAi"

#add api calls here.start with '/api'

if __name__ == '__main__':
    app.run(debug=True)