import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilm/models/dates_list.dart';
import 'package:ilm/providers/calendar.dart';
import 'package:ilm/src/layout/widgets/back_button.dart';
import 'package:ilm/src/layout/widgets/calendar_dates.dart';
import 'package:ilm/src/layout/widgets/task_container.dart';
import 'package:ilm/src/screens/calendar/create_new_task_page.dart';
import 'package:ilm/src/theme/calendar/theme/colors/light_colors.dart';
import 'package:provider/provider.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  double width;
  var isLoading = true;
  List calendarData = [];

  Future getCalendarData() async {
    final token = "xxxxxx"; //uses Shared preferences to get data
    var response =    await Provider.of<Calendar>(context,listen: false ).getCalendar(token);
    if(response != null) {
      print("-------------------------- response Transform to list-------------------------- ");
      response.forEach((key, value){
        print(key);
        calendarData.add( json.encode (value));
      });
      print(calendarData);
      if(calendarData != null){
        if(mounted) {
          setState(() {
            isLoading = false;

          });
        }
      }else{
        var _errormessage = "Un problème est survenue veuillez verifier votre connection";
        isLoading = true;
        _showErrorDialog(_errormessage);
      }
    }
  }


  //Pour afficher un message d'erreur
  void _showErrorDialog(String message){
    showDialog(context: context, builder: (ctx) =>AlertDialog(
      title: Text("Une erreur est survenue"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: (){
            Navigator.of(ctx).pop();
          },
        )
      ],
    ));
  }



  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  var calendarDataLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (calendarData != null) {
      calendarDataLength = calendarData.length;
      getCalendarData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            15,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              _dashedText(),
              // MyBackButton(),
              SizedBox(height: 10.0),
              Container(
                height: 58.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalendarDates(
                      day: days[index],
                      date: dates[index],
                      dayColor: index == 0 ? LightColors.kRed : Colors.black54,
                      dateColor:
                          index == 0 ? LightColors.kRed : LightColors.kDarkBlue,
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Début",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black12,
                        letterSpacing: 5),
                  ),
                  Text(
                    "Fin",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black12,
                        letterSpacing: 5),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              itemCount: calendarData == null ? 0 : calendarData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                    children: <Widget>[
                                      tacheUser(calendarData[index]),
                                      _dashedText(),
                                    ],
                                  )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Generer ici
  Widget tacheInfo(String title, String description, color) {
    Color matColor;
    if(color is String){
        matColor =   Color(0xff4ffa49);
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: TaskContainer(
        title: title,
        subtitle: description,
        boxColor: matColor,
      ),
    );
  }

  Widget tacheUser(devoirs) {
    var calendarContent = json.decode(devoirs);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //SizedBox(width: 20,),
        //L'HEURE ICI
        ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Text(
              calendarContent["debut"].toString(),
              maxLines: 1,
              style: TextStyle(
                  fontSize: 20.0, color: Colors.orange[100], letterSpacing: 5),
            )),
        ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: tacheInfo(
                  calendarContent["title"].toString(), calendarContent["description"].toString(), calendarContent["color"]),
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Text(
            calendarContent["fin"].toString(),
            maxLines: 1,
            style: TextStyle(
                fontSize: 20.0, color: Colors.red[200], letterSpacing: 5),
          ),
        ),
      ],
    );
  }
}
