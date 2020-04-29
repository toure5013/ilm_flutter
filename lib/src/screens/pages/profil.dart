import 'package:flutter/material.dart';
import 'package:ilm/src/layout/widgets/active_project_card.dart';
import 'package:ilm/src/screens/calendar/calendar_page.dart';
import 'package:ilm/src/layout/widgets/task_column.dart';
import 'package:ilm/src/layout/widgets/top_container.dart';
import 'package:ilm/src/screens/pages/AccueilCour.dart';
import 'package:ilm/src/screens/pages/devoir.dart';
import 'package:ilm/src/screens/pages/recomended_page.dart';
import 'package:ilm/src/theme/calendar/theme/colors/light_colors.dart';
import 'package:ilm/src/theme/color/light_color.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: Colors.orange,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }

//----Circular container in header
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.book),
          _bottomIcons(Icons.person),
        ],
        onTap: (index) {
          print(index);
          switch (index) {
            case 0:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CourContent()));
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RecomendedPage()));
              break;
            case 2:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Devoir()));
              break;
            case 3:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Profil()));
              break;
          }
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                    Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                child: Container(
                    height: 200,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                            top: 10,
                            right: -120,
                            child:
                                _circularContainer(300, Colors.orangeAccent)),
                        Positioned(
                            top: -60,
                            left: -65,
                            child: _circularContainer(
                                width * .5, Colors.orangeAccent)),
                        Positioned(
                            top: -230,
                            right: -30,
                            child: _circularContainer(
                                width * .7, Colors.transparent,
                                borderColor: Colors.white38)),
                        Positioned(
                            top: 50,
                            left: 0,
                            child: Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                width: width,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.lock_outline,
                                              color: Colors.red, size: 30.0),
                                          onPressed: () {
                                            print("Déconnexion");
                                          },
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          CircularPercentIndicator(
                                            radius: 90.0,
                                            lineWidth: 5.0,
                                            animation: true,
                                            percent: 0.75,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.green,
                                            backgroundColor:
                                                LightColors.kDarkYellow,
                                            center: CircleAvatar(
                                              backgroundColor:
                                                  LightColors.kBlue,
                                              radius: 35.0,
                                              //AVATAR
                                              backgroundImage: AssetImage(
                                                'assets/images/avatar.png',
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  //USERNAME
                                                  'Touré Souleymane',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  //FONCTION
                                                  'Developer web, mobile & chatbot',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ], ///////////////////
                                          )
                                        ], ////////////////////////
                                      ),
                                    )
                                  ], ////////////////////
                                ))),
                      ], ////////////////////
                    )),
              ),
            ] ///////////////////
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //GRAND TITRE
                              subheading('Mes taches'),

                              //BOUTON DE CALENDRIER
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalendarPage()),
                                  );
                                },
                                child: calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: 'A Faire',
                            subtitle: '5 tâches maintenant',
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'En cours...',
                            subtitle: '1 tâche maintenant. 1 commencé',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check_circle_outline,
                            iconBackgroundColor: LightColors.kBlue,
                            title: 'Terminé',
                            subtitle: '18 taches maintenant',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Active Projects'),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: 'Medical App',
                                subtitle: '9 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kRed,
                                loadingPercent: 0.6,
                                title: 'Making History Notes',
                                subtitle: '20 hours progress',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kDarkYellow,
                                loadingPercent: 0.45,
                                title: 'Sports App',
                                subtitle: '5 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kBlue,
                                loadingPercent: 0.9,
                                title: 'Online Flutter Course',
                                subtitle: '23 hours progress',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
