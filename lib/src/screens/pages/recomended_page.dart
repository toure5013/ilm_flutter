import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilm/models/quad_clipper.dart';
import 'package:ilm/providers/course.dart';
import 'package:ilm/src/layout/header.dart';
import 'package:ilm/src/screens/pages/devoir.dart';
import 'package:ilm/src/screens/pages/AccueilCour.dart';
import 'package:ilm/src/screens/pages/profil.dart';
import 'package:ilm/src/theme/color/light_color.dart';
import 'package:ilm/src/theme/theme.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;

class RecomendedPage extends StatefulWidget {
  @override
  _RecomendedPageState createState() => _RecomendedPageState();
}

class _RecomendedPageState extends State<RecomendedPage> {
  double width;
  var isLoading = true;
  List listCourse = [];
  List cardCont  = [] ;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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


  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(String title) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 20),
                  _chip("Physique & Chimie", LightColor.yellow, height: 5),
                  SizedBox(width: 10),
                  _chip("Mathématique", LightColor.seeBlue, height: 5),
                  SizedBox(width: 10),
                  _chip("Histoire & Géographie", LightColor.orange, height: 5),
                  SizedBox(width: 10),
                  _chip("Anglais", LightColor.lightBlue, height: 5),
                ],
              )),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _card(
      {
        Color primary = Colors.redAccent,
        String imgPath,
        String chipText1 = '',
        String chipText2 = '',
        Widget backWidget,
        Color chipColor = LightColor.orange,
        bool isPrimaryCard = false, String title, String courseNumber, String image}) {
    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(imgPath),
                    )),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _cardInfo(chipText1, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }


  //add paginator
  Widget _courceInfo(dynamic elment, Widget decoration , int index, {Color background}) {
    //Je parse l'objet en m'assurant d'obtenir un courseModel
    var model = json.decode(elment);
    return Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: index%2 == 0?  _card(
                  primary: LightColor.lightOrange,
                  chipColor: LightColor.seeBlue,
                  backWidget: _decorationContainerB(Colors.red, 90, -40),
                  chipText2: model["noOfCource"],
                  isPrimaryCard: true,
                  imgPath: model["image"])
               :_card(
                  primary: LightColor.purple,
                  backWidget:
                  _decorationContainerA(LightColor.lightOrange, 50, -30),
                  chipColor: LightColor.orange,
                  chipText2: model["noOfCource"],
                  isPrimaryCard: true,
                  imgPath: model["image"]
              ),
            ),
            Expanded(
                child: elment == null ? null :  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Text(model["name"],
                                style: TextStyle(
                                    color: LightColor.purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: background,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(model["profFirstname"], //nocour
                              style: TextStyle(
                                color: LightColor.grey,
                                fontSize: 14,
                              )),
                          SizedBox(width: 10)
                        ],
                      ),
                    ),
                    Text(model["university"],
                        style: AppTheme.h6Style.copyWith(
                          fontSize: 12,
                          color: LightColor.grey,
                        )),
                    SizedBox(height: 15),
                    Text(model["description"],
                        style: AppTheme.h6Style.copyWith(
                            fontSize: 12, color: LightColor.extraDarkPurple)),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        _chip(model["tag1"], LightColor.darkOrange, height: 5),
                        SizedBox(
                          width: 10,
                        ),
                        _chip(model["tag2"], LightColor.seeBlue, height: 5),
                      ],
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }



  //---------------------DECORATIONS--------------------------------


  //------------DECORATION WITH IMAGE-----------------------
  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
            CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }



  //---------------NOT IMAGE----------------
  Widget _decorationContainernotimageA() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
            CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainernotimageC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }
  //--------------------DECORATIONS END---------------------------------


  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
      //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }



  //Faire varier la couleur
   double entierAleatoire() {
    //var limite = listCourse != null ? listCourse.length : 50;
    var gnr = new Math.Random();
    //var number = gnr.nextInt(limite);
   // print(number);
  }

  //-------------------------------------------------------------------------------------------------------------------------
                                              //COURSE LIST WIDGET
  //------------------------------------------------------------------------------------------------------------------------------------------
  Widget _courseList() {
    entierAleatoire();
    return ListView.builder(
      itemCount: listCourse == null ? 0 : listCourse.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              index% 2 == 0 ?
              _courceInfo(listCourse[index],
                  _decorationContainerA(Colors.redAccent, -110, -85),index,
                  background: LightColor.seeBlue,)
                :
            _courceInfo(listCourse[index], _decorationContainerB(Colors.red, 90, -40),index,
                background: LightColor.darkOrange),
            //Divider(thickness: 1, endIndent: 20, indent: 20,),
            ],
          ),
        );
      },
    );

    /*
    *
    *     SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            _courceInfo(CourseList.list[1], _decorationContainerB(),
                background: LightColor.darkOrange),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(CourseList.list[2], _decorationContainerC(),
                background: LightColor.lightOrange2),
          ],
        ),
      ),
    );
    * */

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
          currentIndex: 1,
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
                    MaterialPageRoute(builder: (context) => CourContent()));
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
        body:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  headerContent(context, "Cours"),
                  SizedBox(height: 20),
                  _categoryRow("Rétrouvez vos cours ici"),
                 new Expanded(child: listCourse.length == 0 ? CircularProgressIndicator(

                 ) : _courseList())
                ],
              ),
        );
  }
  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)
      ),
      child: Container(
          height: 200,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Search courses",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Type Something...",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}


