import 'package:Bubble/custom-widgets/activityCard.dart';
import 'package:Bubble/custom-widgets/generalCard.dart';
import 'package:Bubble/custom-widgets/lostAndFound.dart';
import 'package:Bubble/pages/register-acc-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './homePage.dart';
import 'homePage.dart';
import 'models/Post.dart';

void main(){
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color(0xFF3A539B),
        accentColor: Color(0xFF3A539B),

        // Define the default font family.
        // fontFamily: 'Robato',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: {
        'home':(context)=> HomePage(),
      },
      initialRoute: 'home',

    );
  }
}

