import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> userInfo(phoneNumber) async{
    String url = "http://192.168.1.7:5000/api/get_auth_info/"+phoneNumber;
    print(url);
    var response = await http.get(url);
    Map auth = jsonDecode(response.body);
    if(auth['user'] == ''){
      return null;
    }
    else{
      Map js = auth['user'];
      print(js);
      return js;
    }
} 

Future<bool> setMedicinesDb(phoneNumber,medicines) async{
    String url = "http://192.168.1.7:5000/api/set_medicine/"+phoneNumber;
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
    String url = "http://192.168.1.7:5000/api/set_relative/"+phoneNumber;
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
            return false;
    }
    catch(Exception){
        print('error');
        return false;
    }
}