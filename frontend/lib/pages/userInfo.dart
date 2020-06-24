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