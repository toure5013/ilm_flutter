
import 'package:flutter/material.dart';

Widget menuContent() {
  return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
                DrawerHeader(
                decoration: BoxDecoration(
                color: Colors.teal,
                ),
                child:  Text(
                  "e-Learn",
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 3.0,
                  ),
                ),
                ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
                ),
                ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                ),
                ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
  );
}



