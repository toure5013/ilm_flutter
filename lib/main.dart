import 'package:flutter/material.dart';
import 'package:ilm/providers/calendar.dart';
import 'package:ilm/providers/course.dart';
import 'package:ilm/src/screens/pages/accueil.dart';
import 'package:ilm/src/screens/pages/others/Accueil.dart';
import 'package:ilm/src/screens/login.dart';
import 'package:ilm/src/theme/color/light_color.dart';
import 'package:provider/provider.dart';

//----------------Carousel package-------------------
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

//Provider
import 'package:ilm/providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Course()),
        ChangeNotifierProvider.value(value: Calendar())
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
            headline: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            title: TextStyle(
                fontSize: 36.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
            body1: TextStyle(
                fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
          ),
        ),
        initialRoute: '/',
        home: MyHomePage(title: 'ILM'),
        //Créer les routes ici et utiliser ansuite
        routes: <String, WidgetBuilder>{
          //Dans la creation des routes si on utilise la propiété home en dessus, on ne peu utiliser  la route racine "/", soit on met home et on enlève la route racine
          //"/" : (context)=> MyHomePage(),
          "/auth": (context) => AuthScreen(),
          "/login": (context) => AuthScreen(),
          "/signup": (context) => AuthScreen(),
          "/accueil": (context) => Accueil(),
          "/accueilcour": (context) => AccueilPage(),
          "/accueil": (context) => AccueilPage(),
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
  List<Slide> slides = new List();

  void calendarAdd() async {
    var response =
        await Provider.of<Calendar>(context, listen: false).saveCalendar(
      "TITRE 2",
      "DESCRIPTION 1......",
      "Colors.teal",
      9,
      20,
      "Lun",
      "Mer",
    );
    print(response);
  }

  @override
  void initState() {
    // Log user in

    super.initState();
    calendarAdd();
    slides.add(
      new Slide(
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff40E0D0),
        title: "SCHOOL",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/photo_school.png",
      ),
    );
    slides.add(
      new Slide(
        colorBegin: Color(0xff7FFFD4),
        colorEnd: Color(0xffFFA500),
        title: "GOMME",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xffFFFACD),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/photo_eraser.png",
      ),
    );
    slides.add(
      new Slide(
        title: "REGLE",
        colorBegin: Color(0xffFFA500),
        colorEnd: Color(0xff7FFFD4),
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/photo_ruler.png",
      ),
    );
    slides.add(
      new Slide(
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff05a623),
        title: "CRAYON",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/photo_pencil.png",
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next screen
    // TODO: go to next screen
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  auth.isAuth ? AccueilPage() : AuthScreen()),
        ));
  }

  void onSkipPress() {
    // TODO: go to next screen
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Consumer<Auth>(
              builder: (ctx, auth, _) =>
                  auth.isAuth ? AccueilPage() : AuthScreen()),
        ));
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xfff5a623),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xfff5a623),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xfff5a623),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33000005),
      highlightColorSkipBtn: Color(0xff000005),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),

      // Dot indicator
      colorDot: Color(0xff20315),
      colorActiveDot: Colors.white,

      // Dot indicator
      sizeDot: 13.0,
    );
  }
}
