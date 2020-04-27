import 'package:flutter/material.dart';
import 'package:ilm/screens/pages/devoir.dart';
import 'package:ilm/screens/pages/recomended_page.dart';
import 'package:ilm/src/layout/footer.dart';
import 'package:ilm/src/layout/header.dart';
import 'package:ilm/src/theme/color/light_color.dart';

import 'home_page.dart';
import 'recomended_page.dart';



class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.purple,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            bottomIconContent(Icons.home),
            bottomIconContent(Icons.star_border),
            bottomIconContent(Icons.book),
            bottomIconContent(Icons.person),
          ],
          onTap: (index) {
            print(index);
            switch(index){
              case 0 :
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
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
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  headerContent(context, 'Profil'),
                  SizedBox(height: 20),
                  SizedBox(height: 0),
                ],
              ),
            )
        )
    );
  }
}
