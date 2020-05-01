import 'package:flutter/material.dart';
import 'package:ilm/models/quad_clipper.dart';
import 'package:ilm/src/layout/categoryinfo.dart';
import 'package:ilm/src/layout/footer.dart';
import 'package:ilm/src/layout/header.dart';
import 'package:ilm/src/screens/pages/accueil.dart';
import 'package:ilm/src/screens/pages/devoir.dart';
import 'package:ilm/src/screens/pages/others/AccueilCour.dart';
import 'package:ilm/src/screens/pages/profil.dart';
import 'package:ilm/src/screens/pages/recomended_page.dart';
import 'package:ilm/src/theme/color/light_color.dart';


class Devoir extends StatefulWidget {
  @override
  _DevoirState createState() => _DevoirState();
}

class _DevoirState extends State<Devoir> {
  int _index = 2;
  double width;
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
          currentIndex: _index,
          items: [
            bottomIconContent(Icons.home),
            bottomIconContent(Icons.star_border),
            bottomIconContent(Icons.book),
            bottomIconContent(Icons.person),
          ],
          onTap: (index) {
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
        body:NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              flexAppBarContent("Dévoir", 150.0, "assets/images/exam.png", Colors.orange),
            ];
          },
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20),
                //categoryRow("Rétrouvez vos cours ici", width),
                new Expanded(
                  child:
                CircularProgressIndicator() ,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
