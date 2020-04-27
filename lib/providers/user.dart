import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Personal modules
import '../models/http_exception.dart'; //give personal exception




class Users with ChangeNotifier{
  final token;

  //Constructor
  Users(this.token);


  //Methods
  Future<void> saveUser(String email, String password) async{
    var apiUrl = "https://e-ilm-1c3e2.firebaseio.com/users.json";
    final response = await http.post(apiUrl, body: json.encode({
      "email" : email,
      "password" : password,
      "returnSecureToken" : true
    }));
    print(response.body);
  }


  Future<void> getUsers(token) async{
    var apiUrl = "https://e-ilm-1c3e2.firebaseio.com/users.json?auth=$token";
    final response = await http.get(apiUrl);
    print(response.body);
  }


}

