const Restify = require('restify')
const methods = require('./methods')
const app = Restify.createServer({
	name: 'Alzheimers bot'
})

app.use(Restify.plugins.jsonp())
app.use(Restify.plugins.bodyParser())

const token = 'abc12345'
const bot = new methods('EAAraMNGr7U8BANsfhJDdGUVhTpHqhQFwbJrF5l7NZApYlkGAS3ahmuKb0ZCu69PlFOnAxKHRnwMSnvknbqe2dZClnJ8k7yxTjLMyUPOqrC2i6hMoZBiygchy9BdDZAZAgKGKVYyUY1tzv4pOyHUPK1IhCZB51AwoENq5ogJ76mj3Wnvp0xhgzeI')

app.get('/', (req, res, next) => {
	if(req.query['hub.mode'] == 'subscribe' && req.query['hub.verify_token'] == token){
 		res.end(req.query['hub.challenge'])
	}
	else{
		next()
	}
})

app.post('/', (req, res, next) =>{
	const response = req.body
	if (response.object == "page") {
		const messageObj = bot.getMessageObject(response)
		// Checking if patient is in a state of panic/anger/sadness
		
		// if (messageObj.need == 'negative') {
		//  	bot.sendText('Do NOT worry, Here are your contact details and name', messageObj.id)
		// }
		if (messageObj.need == 'get_name') {
			bot.sendText('Your name is NAME', messageObj.id)	
		}
		else if (messageObj.need == 'get_contact') {
			bot.sendText('Your known contacts are Contact_1, Contact_2', messageObj.id)
		}
		else if (messageObj.need == 'get_address') {
			bot.sendText('Your address is ADDRESS', messageObj.id)
		}
		else if (messageObj.need == 'get_medicines') {
			bot.sendText('You should take x medicine at 10 AM and y medicine at 5 PM', messageObj.id)
		}
		else if (messageObj.need == 'Empty') {
			bot.sendText('I was unable to catch that phrase, try again in simpler language please!', messageObj.id)
		}
		
		//else {
		//	bot.sendText('Could you ask me in simpler words? I am still learning ;)', messageObj.id)
		//}

		
	}
	res.send(200)
})

app.listen(7558)