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

  bool get isAuth{
    return token != null;
  }

  String get token{
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null){
      return _token;
    }
    return null;
  }


  Future<void> _authenticate(String email, String password, String urlSegement) async{
    var API_KEY = "AIzaSyDD8_TcxMCdp8ED_qCIZtKbBt-fESA3j5U";
    final apiUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegement}?key=${API_KEY}';

    try{
      final response = await http.post(apiUrl, body: json.encode({
        "email" : email,
        "password" : password,
        "returnSecureToken" : true
      }));
      final responseData = json.decode(response.body);
      print(responseData);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData["expiresIn"]),),);
      notifyListeners();

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

  void logout(){
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }


}

