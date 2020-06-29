import requests
import config

class FaceWithAzure:
    def __init__(self,groupId,key=config.AZURE_API_KEY):
        self.groupId = groupId
        self.headers ={
                        'Content-Type': 'application/json',
                        'Ocp-Apim-Subscription-Key': key,
                      }   
    #create person group
    def create_group(self):
        body = dict()
        body["name"] = "relatives"
        body["userData"] = "relatives of "+self.groupId
        body = str(body)
        #Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/'+self.groupId 

        try:
            # Azure call 
            response = requests.put(api_endpoint,data=body, headers=self.headers) 
            print("RESPONSE:" + str(response.status_code))

        except Exception as e:
            print(e)
            print(response.text)
        
    def create_person(self,name="unamed",user_data = ""):
        body = dict()
        body["name"] = name
        body["userData"] = user_data
        body = str(body)

        #Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/'+self.groupId+'/persons' 

        try:
            # Azure call
            response = requests.post(api_endpoint, data=body, headers=self.headers) 
            responseJson = response.json()
            personId = responseJson["personId"]
            print("PERSON ID: "+str(personId))
            return personId
        except Exception as e:
            print(e)
            print(response.text)

    def add_image_to_person(self,personId,url):

        #Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/'+self.groupId+'/persons/'+personId+'/persistedFaces' 

        body = dict()
        body["url"] = url
        body = str(body)

        try:
            # Azure Call 
            response = requests.post(api_endpoint, data=body, headers=self.headers) 
            responseJson = response.json()
            persistedFaceId = responseJson["persistedFaceId"]
            print("PERSISTED FACE ID: "+str(persistedFaceId))
            
        except Exception as e:
            print(e)
            print(response.text)

    def train_group(self):
        body = dict()

        #Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/'+self.groupId+'/train'

        try:
            # REST Call 
            response = requests.post(api_endpoint, data=body, headers=self.headers) 
            print("RESPONSE:" + str(response.status_code))

        except Exception as e:
            print(e)
            print(response.text)

    def detect_face(self,url):
        body = dict()
        body["url"] = url
        body = str(body)

        # Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceAttributes=age,gender,headPose,smile,facialHair' 

        try:
            # Azure Call 
            response = requests.post(api_endpoint, data=body, headers=self.headers)
            js = response.json()
            print("RESPONSE:" + str(js))
            faceId = js[0]['faceId']
            return faceId

        except Exception as e:
            print(e)
            print(response.text)

    def person_identify(self,faceId):
        faceIdsList = [faceId]

        # Request Body
        body = dict()
        body["personGroupId"] = self.groupId
        body["faceIds"] = faceIdsList
        body["maxNumOfCandidatesReturned"] = 1 
        body["confidenceThreshold"] = 0.4
        body = str(body)

        # Request URL 
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/identify' 

        try:
            # Azure Call 
            response = requests.post(api_endpoint, data=body, headers=self.headers) 
            js = response.json()
            personId = js[0]["candidates"][0]["personId"]
            confidence = js[0]["candidates"][0]["confidence"]
            print("PERSON ID: "+str(personId)+ ", CONFIDENCE :"+str(confidence))
            return personId
        except Exception as e:
            print(response.text)
            print(e)
            print("Could not detect")
            
    def person_info(self,personId):
        api_endpoint = 'https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/'+self.groupId+'/persons/'+personId

        try:
            response = requests.get(api_endpoint, headers=self.headers) 
            responseJson = response.json()
            name = responseJson["name"]
            String resp = ("This Is "+str(name)+',your '+responseJson["userData"])
            return resp
            
        except Exception as e:
            print(e)
            return "could not find :("
