import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Personal modules
import '../models/http_exception.dart'; //give personal exception


class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
  var API_KEY = "AIzaSyDD8_TcxMCdp8ED_qCIZtKbBt-fESA3j5U";

  Future<void> _authenticate(String email, String password, String urlSegement) async{
    final apiUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegement}?key=${API_KEY}';
    try{
      final response = await http.post(apiUrl, body: json.encode({
        "email" : email,
        "password" : password,
        "returnSecureToken" : true
      }));

      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
    }catch(error){
      throw error;
    }
  }
  Future<void> signup(String email, String password) async{
    return _authenticate( email,  password, "signUp");
  }

  Future<void> login(String email, String password) async{
    return _authenticate( email,  password, "signInWithPassword");
  }
}