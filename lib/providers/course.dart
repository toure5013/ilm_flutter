import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Personal modules
import '../models/http_exception.dart'; //give personal exception




class Course with ChangeNotifier{
  String name;
  String description;
  String university;
  String noOfCource;
  String tag1;
  String tag2;
  String classe;
  String apiUrl = "https://e-ilm-1c3e2.firebaseio.com/courses.json";

  //Constructor
  Course();


  //Methods
  Future<dynamic> saveCourse(String id, String name, String description,String image, String university, String noOfCource,String tag1,String tag2, String profFirstName, String profLastName) async{

    try{
      //*

      final response = await http.post(this.apiUrl,  body: json.encode({
        "id" : id,
        "name" :name ,
        "description" : description,
        "university" : university,
        "noOfCource" : noOfCource,
        "image" : image,
        "tag1" : tag1,
        "tag2" : tag2,
        "active" : true,
        "profFirstname": profFirstName,
        "profLastname": profLastName
      }));

      //*/
      print("response");
      print(response);

      notifyListeners();

    }catch(error){
      print(error);
      throw error;
    }

  }


  Future getCourses(token) async{

    try{
      final response = await http.get(this.apiUrl);

      final responseData = json.decode(response.body);
      print("status");
      print(response.statusCode);
      //print(responseData);
      notifyListeners();
      return responseData;
    }catch(error){
      print(error);
      throw error;

    }
  }

}

