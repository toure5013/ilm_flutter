import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ilm/providers/course.dart';
import 'package:ilm/src/screens/Accueil.dart';
import 'package:ilm/src/screens/login.dart';
import 'package:ilm/src/screens/pages/AccueilCour.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:ilm/providers/auth.dart';



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
          ChangeNotifierProvider.value(
              value : Course()
          )
          //ChangeNotifierProxyProvider<Auth, Users>(create: (context) => Users(1),)
      ],
      //Avec le consumer je cherche a voir sur l'utilisateur est déjà connecter je le met automatiquement à l'accueil (saute les carousel)
      child: MaterialApp(
        title: 'ILM',
        theme: ThemeData(
          // Define the default font family.
          fontFamily: 'Georgia',
          accentColor: Colors.orange[600],
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
          ),
        ),
        initialRoute: '/',
        home: MyHomePage(title: 'ILM'),
        //Créer les routes ici et utiliser ansuite
        routes: <String, WidgetBuilder> {
          //Dans la creation des routes si on utilise la propiété home en dessus, on ne peu utiliser  la route racine "/", soit on met home et on enlève la route racine
          //"/" : (context)=> MyHomePage(),
          "/auth" : (context)=> AuthScreen(),
          "/login" : (context)=> AuthScreen(),
          "/signup" : (context)=> AuthScreen(),
          "/accueil" : (context)=> Accueil(),
          "/accueilcour" : (context)=> CourContent(),

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
  @override
  void initState() {
    //Si l'utilisateur dure sur la page d'accueil il est renvoyé vers la pges de connexion après 10 secondes
    super.initState();
    // The delay fixes it
    //Future.delayed(Duration(seconds: 10)).then((_) {Navigator.pushReplacementNamed(context, '/login');});
  }


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
    return Scaffold(
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
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Consumer<Auth> (builder: (ctx, auth, _) =>auth.isAuth ? CourContent() : AuthScreen()
             ),
          ));
        },
        tooltip: 'Connexion',
        backgroundColor: Colors.orange,
        focusColor: Colors.teal,
        child: Icon(Icons.book, color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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
                        onTap: ()async {
                          print("clicked");
                            // Log user in
                            await Provider.of<Course>(context,listen: false ).saveCourse(
                                "nsjdbsqkjdbkjqs",
                                "Masse et poids",
                                "This specialization from leading researchers at university of washington introduce to you to the exciting high-demand field of machine learning ",
                               "https://media-exp1.licdn.com/dms/image/C5603AQG2GK8T5W_cDQ/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=SnOUo0gWh0EGDGwVKZ36OENpFLW933cr-i1tKqWC4-k",
                              "University of washington",
                                "8 courses",
                                "Physique",
                                 "Force & énergie",
                                "TOURE",
                                "SOULEYMANE"
                            );
                          
                        },
                      ),
                      // FlatButton(child: Text("calend"), onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => eventContent()));}),
                    ],
                  ),
                ),
              ),
        )
    );

  }
}
