const request = require('./requestPromise')

module.exports = class methds{
	constructor(access_token){
		this.ACCESS_TOKEN = access_token
	}

	async sendText(text, id){

		const json = {
			recipient: { id },
			message: { text }
		}

		const res = await request({
			url: "https://graph.facebook.com/v7.0/me/messages",
			qs: {
				access_token : this.ACCESS_TOKEN
			},
			json,
			method: 'POST'
		})

		console.log('Facebook says: ', res)
	}

	getMessageObject(json) {
		const message = json.entry[0].messaging[0].message.text
		const id = json.entry[0].messaging[0].sender.id
		const need = json.entry[0].messaging[0].message.nlp.entities.intent[0].value
		// var flag = 0
		// var need = ""
		// if (json.entry[0].messaging[0].message.nlp.entities.length == 2) {
		// 	flag = 1
		// }

		// console.log(flag)

		// if( flag == 1) {
		// 	need = "Empty"
		// }
		// else if (flag == 0) {
		// 	need = json.entry[0].messaging[0].message.nlp.entities.intent[0].value
		// }

		
		return {message, id, need}
	}
}