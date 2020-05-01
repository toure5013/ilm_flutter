import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilm/models/quad_clipper.dart';
import 'package:ilm/providers/course.dart';
import 'package:ilm/src/layout/card.dart';
import 'package:ilm/src/layout/categoryinfo.dart';
import 'package:ilm/src/layout/decorators.dart';
import 'package:ilm/src/layout/header.dart';
import 'package:ilm/src/screens/pages/accueil.dart';
import 'package:ilm/src/screens/pages/devoir.dart';
import 'package:ilm/src/screens/pages/others/AccueilCour.dart';
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
              child: index%2 == 0?  cardContent(
                width,
                  primary: LightColor.lightOrange,
                  chipColor: LightColor.seeBlue,
                  backWidget: _decorationContainerB(Colors.red, 90, -40),
                  chipText2: model["noOfCource"],
                  isPrimaryCard: true,
                  imgPath: model["image"])
               :cardContent(
                  width,
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
                        chip(model["tag1"], LightColor.darkOrange, height: 5),
                        SizedBox(
                          width: 10,
                        ),
                        chip(model["tag2"], LightColor.seeBlue, height: 5),
                      ],
                    )
                  ],
                ))
          ],
        ));
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
        smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: circularContainer(80, Colors.transparent,
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

  //--------------------DECORATIONS END---------------------------------



  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
      //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }




  //-------------------------------------------------------------------------------------------------------------------------
                                              //COURSE LIST WIDGET
  //------------------------------------------------------------------------------------------------------------------------------------------
  Widget _courseList() {
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
              flexAppBarContent("Cours", 150.0, "assets/images/chapeau.png", LightColor.purple),
            ];
          },
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20),
                categoryRow("Rétrouvez vos cours ici", width),
                new Expanded(child: listCourse.length == 0 ? CircularProgressIndicator(

                ) : _courseList())
              ],
            ),
          ),
        ),


        );
  }

}


