


//---------------NOT IMAGE----------------
import 'package:flutter/material.dart';
import 'package:ilm/src/theme/color/light_color.dart';
import 'package:ilm/models/quad_clipper.dart';




//---------Container--------------------
Widget circularContainer(double height, Color color,
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





Positioned smallContainer(Color primaryColor, double top, double left,
    {double radius = 10}) {
  return Positioned(
      top: top,
      left: left,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: primaryColor.withAlpha(255),
      ));
}


//---------Decorators--------------------

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
        child: circularContainer(70, Colors.transparent,
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
      smallContainer(
        Colors.yellow,
        35,
        70,
      ),
    ],
  );
}