
import 'package:flutter/material.dart';

Widget logoLogin() {
  return  Container(
    padding: EdgeInsets.only(top: 20.0),
    child:Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(60.0),
          child: Image.asset(
            "assets/images/astro.jpg",
            width: 90,
          )
      ),
    ),
  );
}