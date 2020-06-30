import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> userInfo(phoneNumber) async{
    String url = "https://memorai.herokuapp.com/api/get_auth_info/"+phoneNumber;
    print(url);
    var response = await http.get(url);
    Map auth = jsonDecode(response.body);
    if(auth['user'] == ''){
      return null;
    }
    else{
      Map js = auth['user'];
      return js;
    }
} 

Future<bool> setMedicinesDb(phoneNumber,medicines) async{
    String url = "https://memorai.herokuapp.com/api/set_medicine/"+phoneNumber;
    Map<String,String> headers = {"Content-type" : "application/json"};
    Map js = {"data":medicines}; //ADD OTHER INFO
    var body = json.encode(js);
    try{
          var response = await http.post(url,headers:headers,body: body);
          
          int code = response.statusCode;
          print(code);
          if (code<300){
              print('success');
              return true;
          }
          else
            print('error');
            return false;
    }
    catch(Exception){
        print('error');
        return false;
        
    }
}

Future<bool> setRelativesDb(phoneNumber,relatives) async{
    String url = "https://memorai.herokuapp.com/api/set_relative/"+phoneNumber;
    Map<String,String> headers = {"Content-type" : "application/json"};
    Map js = {"data":relatives}; //ADD OTHER INFO
    var body = json.encode(js);
    try{
          var response = await http.post(url,headers:headers,body: body);
         
          int code = response.statusCode;
          print(code);
          if (code<300){
              print('success');
              return true;
          }
          else
            print('error');
            return null;
    }
    catch(Exception){
        print('error');
        return null;
    }
}

Future<String> identifyPerson(phoneNumber,detectUrl) async{
    
    //String url = 'http://192.168.1.7:5000/api/check_face/'+phoneNumber;
    String url = 'https://memorai.herokuapp.com/api/check_face/' + phoneNumber;
    print(url);
    Map<String,String> headers = {"Content-type" : "application/json"};
    Map js = {"detect_url" : detectUrl}; //ADD OTHER INFO
    var body = json.encode(js);
    try{
          var response = await http.post(url,headers:headers,body: body);
          int code = response.statusCode;
          Map res = jsonDecode(response.body);
          print(code);
          if (code<300 &&  res['status']=='success' ){
              
              return res['response'];
          }
          else
            print('error');
            return null;
    }
    catch(e){
        print(e.message);
        return null;
    }
}