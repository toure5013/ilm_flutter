import 'package:flutter/material.dart';
import 'package:ilm/src/theme/color/light_color.dart';

Widget chip(String text, Color textColor,
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


Widget categoryRow(String title, width) {
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
                chip("Physique & Chimie", LightColor.yellow, height: 5),
                SizedBox(width: 10),
                chip("Mathématique", LightColor.seeBlue, height: 5),
                SizedBox(width: 10),
                chip("Histoire & Géographie", LightColor.orange, height: 5),
                SizedBox(width: 10),
                chip("Anglais", LightColor.lightBlue, height: 5),
              ],
            )),
        SizedBox(height: 10)
      ],
    ),
  );
}