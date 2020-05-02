import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//Personal modules
import '../models/http_exception.dart'; //give personal exception

class Calendar with ChangeNotifier {

  String apiUrl = "https://e-ilm-1c3e2.firebaseio.com/calendar.json";

  Calendar();

  //Methods
  Future<dynamic> saveCalendar(
      String title,
      String description,
      var color,
       debut,
       fin,
      String jourDebut,
      String jourFin) async {
      try {
        final response = await http.post(this.apiUrl,
            body: json.encode({
              "title": title,
              "description": description,
              "color": color,
              "debut": debut,
              "fin": fin,
              "jourDebut": jourDebut,
              "jourFin": jourFin,
            }));
        final responseData = json.decode(response.body);
        notifyListeners();
        return responseData;
      } catch (error) {
        print(error);
        throw error;
      }
  }



  Future getCalendar(token) async {
    try {
      final response = await http.get(this.apiUrl);
      final responseData = json.decode(response.body);
      print("status");
      print(response.statusCode);
      //print(responseData);
      notifyListeners();
      return responseData;
    } catch (error) {
      print(error);
      throw error;
    }
  }


}
