import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {  
  runApp(MyApp());  
}  
class MyApp extends StatefulWidget {  
  @override  
  _MyAppState createState() => _MyAppState();  
}  
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {  
        return MaterialApp( 
          home: Scaffold(
          
            body: Center(
              
              child : Padding(
                padding: const EdgeInsets.only(top:100),
                child: Column(
                  children: <Widget>[
                    Image.asset('images/banner_white.png',height : 80),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Text('Sample text for moto',
                        style: TextStyle(
                          color: Color(0xFFEBF2FA),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'WorkSans',
                          letterSpacing: 2
                        ),
                      ),
                    ),
                    Container(
                      
                      margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top : 100),
                          child: Container(
                            child: Column(
                              children: [

                                new RaisedButton(

                                    padding: EdgeInsets.only(left: 3 , top : 3 , bottom : 3),
                                    color: const Color(0xFFEBF2FA),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                    onPressed: () {},
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.min,

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top:1,bottom:1,left:1),
                                          child: new Image.asset(
                                            'images/google2.png',
                                            height: 45.0,
                                          ),
                                        ),
                                        new Container(
                                          padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                            child: new Text("Sign in with Google",style: TextStyle(
                                              fontFamily: 'WorkSans'
                                            ))
                                        ),
                                      ],
                                    )
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: new RaisedButton(
                                      padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 3.0),
                                      color: const Color(0xFFEBF2FA),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                      onPressed: () {},
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,

                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top:1,bottom:1,left:1),
                                            child: new Image.asset(
                                              'images/facebook.png',
                                              height: 45.0,
                                            ),
                                          ),
                                          new Container(
                                            padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                              child: new Text("Sign in with Facebook",style: TextStyle(
                                                fontFamily: 'WorkSans'
                                              ))
                                          ),
                                        ],
                                      )
                                    ),
                                ),
                              ],
                            ),

                          ),
                            
                        ),
                        ),
                      ),
                  ],
                  
                ),
              ),
              
              
              
            ),
            backgroundColor: const Color(0xFF3A539B),

      ),
    );
}
}
