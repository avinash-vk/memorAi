from flask import Flask,jsonify,request,Response,render_template
from wit import Wit
import os
import json
import pyrebase
app = Flask(__name__)

#wit.ai bot
access_token = 'PQWCP34JWQI3KFAGX3IJGZBDH7JN66LM'

# Initialize Firestore DB
config = {
    "apiKey": 'AIzaSyAY3r-JFmZH2G96JNYz9nLwLkgbUEtnl-0' ,
    "authDomain": "memorai-920f7.firebaseapp.com",
    "databaseURL": "https://memorai-920f7.firebaseio.com",
    "projectId": "memorai-920f7",
    "storageBucket": "memorai-920f7.appspot.com",
    "messagingSenderId": "310050900810",
    "appId": "1:310050900810:web:e00eaa3054f5bfb2238fb3",
    "measurementId": "G-K71LF47NZ8"
}
firebase = pyrebase.initialize_app(config)
db = firebase.database()

@app.route('/')
def main():
    return "welcome to memorAi"

@app.route('/api/createUser',methods = ['POST'])
def createUser():    
    data = request.json
    print(data,type(data))
    db.child('users').child(data['emergency_pno']).set(data)
    return Response({'status':'success'})

@app.route('/api/get_auth_info/<number>')
def getAuthInfo(number):
    try:
        user = {}
        user = db.child('users').child(number).get()
        d = dict(user.val())
        return jsonify({'user':d})
    except Exception as e:
        print(e)
        return jsonify({'user':str()})

@app.route('/api/set_medicine/<number>',methods = ['POST'])
def update_medicines(number):
    data = request.json
    print(data)
    db.child('users').child(number).update({"medicines": data['data']})
    return Response({'status':'success'}) 

@app.route('/api/set_relative/<number>',methods = ['POST'])
def update_relatives(number):
    data = request.json
    print(data)
    db.child('users').child(number).update({"relatives": data['data']})
    return Response({'status':'success'}) 

@app.route('/test')
def botTest():
    return render_template('test.html')

#add api calls here.start with '/api'
@app.route('/api/chatbot/<number>/<message>')
def chatbot(number,message):
    client = Wit(access_token)
    bot_response = client.message(message)
    entity = bot_response['entities']
    per = dict(db.child('users').child(number).get().val())
    intent = ''
    sentiment = ''
    notif = 'no'
    reminder= ''
    dt = ''
    if bot_response['intents']:
        intent = bot_response['intents'][0]['name']

    if bot_response['traits'] and bot_response['traits']['wit$sentiment']:
        sentiment = bot_response['traits']['wit$sentiment'][0]['value']

    chat_response = 'Hmm..'

    if intent == 'get_name':
        #todo db call
        name = per['patient_name']
        chat_response = 'Haha your name is '+name+'\n Hello '+name+'!'
    
    elif intent == 'get_contact':
        #todo db call
        contact = per['emergency_pno']
        chat_response = 'Your emergency contact is '+contact+' take care.'

    elif intent == 'get_medicines':
        #todo db call
        
        medicines = per['medicines']
        
        chat_response = ''
        for i in medicines:
            medicine = [i['name'],i['hour'],i['min']]
            chat_response+= medicine[0]+' at '+str(medicine[1])+':'+str(medicine[2])+'\n'
        if chat_response:
            chat_response = 'Your medicines listed for today are:\n' + chat_response
        else:
            'no medicines listed!'
    elif intent == 'get_address':
        #todo db call
        address = str(per['patient_location']['lat'])+','+str(per['location']['long'])
        chat_response = 'You live at '+address

    elif intent == 'get_greeting':
        chat_response = 'Hello, hope your day is going alright!'  
        #and other such greetings likewise -> can be finalized later
    elif intent == 'get_reminder':
    	#A couple of if statements to check if datetime and reminder entities of get_reminder exist
    	#Inside these if statements, we could append the datetime and reminder entities to the reminder list
        if entity["wit$datetime:datetime"] and entity["wit$reminder:reminder"]:
            obj =  entity["wit$datetime:datetime"][0]["value"]
            date = obj[:10]
            time = obj[11:16]
            reminder = entity["wit$reminder:reminder"][0]["body"]
            chat_response = "Reminder set : "+reminder+" at "+time+" on "+date
            notif='yes'
            dt = date+' '+time

    elif sentiment == 'negative':
        chat_response = 'Oh no :( Things are going to get better. Wanna talk to someone?'
    
    response = dict()
    response['bot_response'] = bot_response
    response['chat_response'] = chat_response
    response['notif'] = notif
    response['dt'] = dt
    response['reminder'] = 'You have to '+reminder
    return response



#comment below call for local setup
if __name__ == '__app__':
    app.run(port=5000) 

#Uncomment this for local run
#app.run(host="0.0.0.0",port=5000)  

