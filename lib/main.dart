import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:ilm/providers/user.dart';
import 'package:ilm/providers/auth.dart';

//Screen
import 'package:ilm/screens/Accueil.dart';
import 'package:ilm/screens/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(
        value : Auth()
        ),
          //ChangeNotifierProxyProvider<Auth, Users>(create: (context) => Users(1),)
      ],
      //Avec le consumer je cherche a voir sur l'utilisateur est déjà connecter je le met automatiquement à l'accueil (saute les carousel)
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        //Créer les routes ici et utiliser ansuite
        routes: <String, WidgetBuilder> {
          "/auth" : (context)=> AuthScreen(),
          "/login" : (context)=> AuthScreen(),
          "/signup" : (context)=> AuthScreen(),
          "/accueil" : (context)=> Accueil(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*"assets/images/back.jpeg",*/
class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  List text = ["Apprendre", "Comprendre", "Vaincre", "Expertise", "Meilleur","Expertise",
  ];
  List textsubtitle = [
    "Apprendre",
    "Comprendre",
    "Vaincre",
    "Expertise",
    "Meilleur",
    "Expertise",
  ]
  ;
  List imageLink = ["assets/images/LOGO.png", "assets/images/assise_sur_livre.png", "assets/images/amis_elves.png", "assets/images/reading_4boi.png", "assets/images/reading_time_gvg0.png", "assets/images/exam.png"];


  void _incrementCounter() {
    setState(() {
      //Actualisé létat de l'appli ici
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<Auth> (builder: (ctx, auth, _) =>auth.isAuth ? Accueil() : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/afrique.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: bodyContent()),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            //Avec le consumer je cherche a voir sur l'utilisateur est déjà connecter je le met automatiquement à l'accueil (saute le login)
            MaterialPageRoute(builder: (context) =>auth.isAuth ? Accueil() : AuthScreen()),
          );
        },
        tooltip: 'Connexion',
        backgroundColor: Colors.orange,
        child: Icon(Icons.book),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }


  //---------Body content here-----------
  Widget bodyContent() {
    int _nbreSlide = text.length;
    return Center(
        child:
        CarouselSlider.builder(
          options:  CarouselOptions(
            height: 350,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: _nbreSlide,
          itemBuilder: (BuildContext context, int itemIndex) =>
              Container(

                child: Card(
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(imageLink[itemIndex],
                        fit: BoxFit.fill,
                        height: 200,),
                      ListTile(
                        leading: Icon(Icons.print),
                        title: Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${text[itemIndex]}'),
                          ],
                        ),
                        subtitle: Text(textsubtitle[itemIndex]),
                        onTap: (){
                          print("clicked");
                        },
                      )
                    ],
                  ),
                ),
              ),
        )
    );

  }
}
