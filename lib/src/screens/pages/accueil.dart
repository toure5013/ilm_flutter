import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilm/models/quad_clipper.dart';
import 'package:ilm/providers/course.dart';
import 'package:ilm/src/layout/card.dart';
import 'package:ilm/src/layout/categoryinfo.dart';
import 'package:ilm/src/layout/decorators.dart';
import 'package:ilm/src/layout/header.dart';
import 'package:ilm/src/screens/calendar/calendar_page.dart';
import 'package:ilm/src/screens/pages/devoir.dart';
import 'package:ilm/src/screens/pages/others/AccueilCour.dart';
import 'package:ilm/src/screens/pages/profil.dart';
import 'package:ilm/src/screens/pages/recomended_page.dart';
import 'package:ilm/src/theme/color/light_color.dart';
import 'package:ilm/src/theme/theme.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  double width;
  var isLoading = true;
  List listCourse = [];
  List cardCont  = [] ;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(isLoading){
      getData();
    }else{
      return;
    }
  }
  //Pour afficher un message d'erreur
  void _showErrorDialog(String message){
    showDialog(context: context, builder: (ctx) =>AlertDialog(
      title: Text("Une erreur est survenue"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: (){
            Navigator.of(ctx).pop();
          },
        )
      ],
    ));
  }

  Future getData() async {
    final token = "xxxxxx"; //uses Shared preferences to get data
    var response =    await Provider.of<Course>(context,listen: false ).getCourses(token);
    if(response != null) {
      print("-------------------------- response Transform to list-------------------------- ");
      response.forEach((key, value){
        print(key);
        listCourse.add( json.encode (value));
        print(cardCont);
      });

      if(listCourse != null){
        if(mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }else{
        var _errormessage = "Un problème est survenue veuillez verifier votre connection";
        isLoading = true;
        _showErrorDialog(_errormessage);
      }

    }
  }







  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
      //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }





  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.book),
          _bottomIcons(Icons.person),
        ],
        onTap: (index) {
          print(index);
          switch(index){
            case 0 :
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AccueilPage()));
              break;
            case 1 :
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RecomendedPage()));
              break;
            case 2 :
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Devoir()));
              break;
            case 3 :
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Profil()));
              break;
          }

        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            flexAppBarContent("Accueil", 80.0, "assets/images/livre.png", LightColor.purple),
          ];
        },
        body: CalendarPage()
      ),


    );
  }

}


