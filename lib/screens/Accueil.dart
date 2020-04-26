import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ilm/sections/appBar.dart';
import 'package:ilm/sections/menu.dart';


class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}



class _AccueilState extends State<Accueil> {

  List<IconData> icons = [
    Icons.directions_bike, Icons.directions_boat,
    Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
    Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
    Icons.directions_walk
  ];
  var _isInit = true;
  var isLoading = true;

  //Data getted params
  String data;
  var dataGettedLength;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {

    http.Response response =  await http.get("https://protocoderspoint.com/jsondata/superheros.json");
    print(response.body);
    //if response is 200 : success that store
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      print(data);
      setState(() {
        dataGettedLength = jsonDecode(data)['superheros']; //get all the data from json string superheros
        print(dataGettedLength.length); // just printed length of data
        isLoading = false;
      });
      var venam = jsonDecode(data)['superheros'][4]['url'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Http Example"),
      ),
      drawer: menuContent(),
      body: isLoading == true ? Center(
        child: CircularProgressIndicator(),
      ) :  ListView.builder(
        itemCount: dataGettedLength == null ? 0 : dataGettedLength.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(
                  jsonDecode(data)['superheros'][index]['url'],
                  fit: BoxFit.fill,
                  width: 90,
                  height: 150,
                  alignment: Alignment.center,
                ),
                ListTile(
                  leading: Image.network(
                    jsonDecode(data)['superheros'][index]['url'],
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                  ),
                  title: Text(jsonDecode(data)['superheros'][index]['name']),
                  subtitle: Text(jsonDecode(data)['superheros'][index]['power']),
                  onTap: (){
                    print("clicked");
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


