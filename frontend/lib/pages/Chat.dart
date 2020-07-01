import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map js;
  
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  ChatUser user;
  String pno='';
  /* = ChatUser(
      name: 'pat',
      firstName: 'pat',
      lastName: 'pat',
      uid: '1234',
      containerColor: Colors.redAccent,
      avatar:"https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
    );*/
  var isLoading = true;
  final ChatUser bot = ChatUser(
    name: "BOT",
    uid: "25649654",
    avatar: 'https://images.vexels.com/media/users/3/152299/isolated/preview/4f63af6a16633f2bfd29063205f2882c-astronaut-flying-cartoon-by-vexels.png',
  );

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState(){

    super.initState();
    new Future<List>.delayed(new Duration(seconds: 1), () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    Map js = await userInfo(pno);
    //print(js);
    ChatUser userx = ChatUser(
      name: js['name'],
      firstName: js['name'],
      lastName: js['name'],
      uid: pno,
      containerColor: Colors.redAccent,
      avatar: (js['patient_dp']==null)?"https://images.unsplash.com/photo-1506794778202-cad84cf45f1d":js['patient_dp'],
    );
    return [userx,js];
    }).then((List list) {
      setState(() {
        user = list[0];
        pno= list[0].uid;
        js = list[1];
        isLoading = false;
        
      });
    });
    
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  Future<void> onSend(ChatMessage message,{String detect_url = ''}) async {
    setState(() {
      messages = [...messages,message];
      print(messages.length);
    });
    print('here');
    if ( i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    }
    else {
      systemMessage();
    } 
    if(detect_url==''){
      print(pno);
      final url = 'https://memorai.herokuapp.com/api/chatbot/' + pno+'/'+ message.text;
      print(js['patient_location']['lat']);
      var answer = await http.get(url);
      var obj = (jsonDecode(answer.body));
      var chatResponse = obj['chat_response'];
      if(chatResponse == 'Open the maps')
      {
        var lat = (js['patient_location']['loc']);
        var lon = (js['patient_location']['lat']);
        assert(lat is double);
        assert(lon is double);
        MapsLauncher.launchCoordinates(lat,lon);
      }
        final botReply = ChatMessage(
              text: chatResponse,
              createdAt: DateTime.now(),
              user: bot);
        setState(() {
          messages = [...messages,botReply];
          print(messages.length);
        });

        if ( i == 0) {
          systemMessage();
          Timer(Duration(milliseconds: 600), () {
            systemMessage();
          });
        } 
        else {
          systemMessage();
          } 
        
      }
    else{
        final message = ChatMessage(
            text: 'hmm...let me see',
            createdAt: DateTime.now(),
            user: bot);
        setState(() {
        messages = [...messages,message];
        print(messages.length);
      });
      print("Goinf into call");
      String person = '';
      try{
        person = await identifyPerson(pno,detect_url); }
      catch(Exception){
        person = 'couldn\'t detect properly';
      }
      if (person == null){ person = 'couldn\'t detect properly';}
      final mess = ChatMessage(
          text: person,
          createdAt: DateTime.now(),
          user: bot);
      setState(() {
      messages = [...messages,mess];
      print(messages.length);
    });

    if ( i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });

    }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(),
      body:
      (isLoading)? Text('Loading')
      :DashChat(
                
                key: _chatViewKey,
                inverted: false,
                onSend: onSend,
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: user,
                scrollToBottomStyle: ScrollToBottomStyle(backgroundColor: Colors.redAccent),
                inputDecoration:
                    InputDecoration.collapsed(
                        fillColor: Colors.redAccent,
                        hintText: "Add message here..."),
                dateFormat: DateFormat('yyyy-MMM-dd'),
                timeFormat: DateFormat('HH:mm'),
                messages: messages,
                showUserAvatar: true,
                showAvatarForEveryMessage: false,
                scrollToBottom: true,
                onPressAvatar: (ChatUser user) {
                  print("OnPressAvatar: ${user.name}");
                },
                onLongPressAvatar: (ChatUser user) {
                  print("OnLongPressAvatar: ${user.name}");
                },
                inputMaxLines: 5,
                
                messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                alwaysShowSend: true,
                inputTextStyle: TextStyle(fontSize: 18.0),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(
                    color:Colors.redAccent,
                    width: 2.0),
                  color: Colors.white,
                ),
                
                onLoadEarlier: () {
                  print("loading...");
                },
                shouldShowLoadEarlier: false,
                showTraillingBeforeSend: true,
                trailing: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final img = await picker.getImage(
                        source: ImageSource.gallery,
                      );
                      File result = File(img.path);
                      if (result != null) {
                        final StorageReference storageRef =
                            FirebaseStorage.instance.ref().child("chat_images");

                        StorageUploadTask uploadTask = storageRef.putFile(
                          result,
                          StorageMetadata(
                            contentType: 'image/jpg',
                          ),
                        );
                        StorageTaskSnapshot download =
                            await uploadTask.onComplete;

                        String url = await download.ref.getDownloadURL();

                        ChatMessage message =
                            ChatMessage(text: "", user: user, image: url);
                        onSend(message,detect_url : url);
                        
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: (){
                      String url = "https://static.toiimg.com/thumb/msid-54559212,width-748,height-499,resizemode=4,imgsize-307081/Bangalore.jpg";
                      ChatMessage message =
                            ChatMessage(text: "", user: user, image: url);
                        onSend(message,detect_url : url);
                    },
                  ),
                ],
                )
                
                );

   
          
  }
}

