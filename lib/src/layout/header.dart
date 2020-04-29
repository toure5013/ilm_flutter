import 'package:flutter/material.dart';
import '../theme/color/light_color.dart';

Widget headerContent(BuildContext context, String headerText) {
  var width = MediaQuery.of(context).size.width;
  return ClipRRect(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
    child: Container(
        height: 120,
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
                child: _circularContainer(300, Colors.orangeAccent)),
            Positioned(
                top: -60,
                left: -65,
                child: _circularContainer(width * .5, Colors.orangeAccent)),
            Positioned(
                top: -230,
                right: -30,
                child: _circularContainer(width * .7, Colors.transparent,
                    borderColor: Colors.white38)),
            Positioned(
                top: 50,
                left: 0,
                child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: <Widget>[
                        Image.asset("assets/images/LOGO.png", width: 70,),

                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              headerText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ))),
          ],
        )),
  );
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



//____________________________________________________________________________________
Widget headerPurple(BuildContext context) {
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