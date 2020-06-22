# memorAi

memorAi is an application aimed at helping individuals diagnosed with alzheimers disease. The app helps patients keep track of their tasks,medicines,close family friends and relatives. The app has an chatbot service leveraging the wit.ai platform for easier conversation between the patient and memorAi. The chatbot helps schedule tasks,remind medicines and records sentiments of the patient. More to be disclosed soon ;)

memorAi is flutter application that interacts with a flask backend.

## Setup

**Clone the repo and navigate to it**
```bash
git clone https://github.com/avinash-vk/memorAi.git
cd memorAi
```

**To run the flutter app:**
Download [flutter](https://flutter.dev/docs/get-started/install) and follow the setup instructions.
After that from the root directory:
```bash
cd frontend
flutter run
```


**To run the flask backend**
- Download [pip](https://pip.pypa.io/en/stable/installing/)
- Download [python 3](https://www.python.org/downloads/)
- Create and activate your virtual environment 
- Make sure to make changes in app.py if the app is running in a development environment
- From the root directory run:
```bash
    pip install -r requirements.txt
    python app.py
```
- navigate to 127.0.0.1:5000 and your app should be running there.

**backend url** : https://memorai.herokuapp.com/

*To test the chatbot go to*: https://memorai.herokuapp.com/test