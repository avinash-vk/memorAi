from flask import Flask,jsonify,request,Response,render_template

from wit import Wit

app = Flask(__name__)
access_token = 'PQWCP34JWQI3KFAGX3IJGZBDH7JN66LM'

@app.route('/')
def main():
    return "welcome to memorAi"

@app.route('/test')
def botTest():
    return render_template('test.html')

#add api calls here.start with '/api'
@app.route('/api/chatbot/<message>')
def chatbot(message):
    client = Wit(access_token)
    response = client.message(message)
    return response

#comment below call for local setup
if __name__ == '__app__':
    app.run(port=5000) 
#app.run(port=5000)  

