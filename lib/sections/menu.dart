
import 'package:flutter/material.dart';
import 'package:ilm/providers/auth.dart';
import 'package:provider/provider.dart';

Widget menuContent(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/LOGO.png"), fit: BoxFit.cover)),
          child: Image.asset( "assets/images/LOGO.png"),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle: Text(
                'A sufficiently long subtitle warrants three lines.'
            ),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.account_circle, color: Colors.orange,),
            title: Text('Profile'),
            onTap: (){
            },
          ),
        ),
        Divider(),
        Card(
          child: ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.orange,),
            title: Text('Deconnexion'),
            onTap: (){
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ),

      ],
    ),
  );
}



