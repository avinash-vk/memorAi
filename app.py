from flask import Flask,jsonify,request,Response,render_template

from wit import Wit

app = Flask(__name__)

#wit.ai bot
access_token = 'PQWCP34JWQI3KFAGX3IJGZBDH7JN66LM'

# Initialize Firestore DB
'''cred = credentials.Certificate('./key.json')
fireapp = initialize_app(cred)
db = fireapp.Firestore()
'''

@app.route('/')
def main():
    return "welcome to memorAi"

@app.route('/api/createUser',methods = ['POST'])
def createUser():
    data = request.json
    print(data)
    return Response({'status':'success'})
'''
@app.route('/api/getPatientInfo'):
def patient_info():
    data = request.json
    print(data)

@app.route('/api/add_patient_relative'):
def add_patient_relatives():
    data = request.json
    print(data)

@app.route('/api/get_patient_relative'):
def get_patient_relatives():
    data = request.json
    print(data)

@app.route('/api/update_patient_relative'):
def update_patient_relatives():
    data = request.json
    print(data)

@app.route('/api/add_medicines'):
def add_medicine():
    data = request.json
    print(data)

@app.route('/api/remove_medicines'):
def remove_medicine():
    data = request.json
    print(data)

@app.route('/api/get_medicines'):
def get_medicine():
    data = request.json
    print(data)
'''
@app.route('/test')
def botTest():
    return render_template('test.html')

#add api calls here.start with '/api'
@app.route('/api/chatbot/<message>')
def chatbot(message):
    client = Wit(access_token)
    bot_response = client.message(message)
    entity = bot_response['entities']
    intent = ''
    sentiment = ''
    reminder = list() #Append reminders here

    if bot_response['intents']:
        intent = bot_response['intents'][0]['name']

    if bot_response['traits'] and bot_response['traits']['wit$sentiment']:
        sentiment = bot_response['traits']['wit$sentiment'][0]['value']

    chat_response = 'Hmm..'

    if intent == 'get_name':
        #todo db call
        name = 'joe'
        chat_response = 'Haha your name is '+name+'\n Hello '+name+'!'
    
    elif intent == 'get_contact':
        #todo db call
        contact = '+916969696969'
        chat_response = 'Your emergency contact is '+contact+' take care.'

    elif intent == 'get_medicine':
        #todo db call
        medicine = [['2pm','crocin'],['3pm','sleeping pills']]
        chat_response = ''
        for i in medicine:
            chat_response+= medicine[1]+' at '+medicine[0]
        if chat_response:
            chat_response = 'Your medicines listed for today are:\n' + chat_response
        else:
            'no medicines listed!'
    elif intent == 'get_address':
        #todo db call
        address = '12th street oxford street'
        chat_response = 'You live at '+address

    elif intent == 'get_greeting':
		chat_response = 'Hello, hope your day is going alright!'  
		#and other such greetings likewise -> can be finalized later

    elif intent == 'get_reminder':
    	#A couple of if statements to check if datetime and reminder entities of get_reminder exist
    	#Inside these if statements, we could append the datetime and reminder entities to the reminder list
    	if <enter condition here>:
    		reminder.append(<variable containing either the message or a concatentation of datetime and reminder)
		chat_response = 'You have the following reminders:' + reminder
		#Also, datetime entity identifies stuff like today and tomorrow and stores a date accordingly
		#So if we wanna further classify reminders based on today/tmrw etc, we can. Though it might be too cumbersome
		

    elif sentiment == 'negative':
        chat_response = 'Oh no :( Things are going to get better. Wanna talk to someone?'
    
    response = dict()
    response['bot_response'] = bot_response
    response['chat_response'] = chat_response
    
    return response

#comment below call for local setup
if __name__ == '__app__':
    app.run(port=5000) 

#Uncomment this for local run
#app.run(port=5000)  

