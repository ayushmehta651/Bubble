import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import './pages/register-acc-page.dart';


void main() => runApp(MaterialApp(home: Login()));



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoggedIn = false;

  // final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Map userProfile;

  _glogin() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = !_isLoggedIn;
      });
    } catch (err) {
      print(err + 'error cameing');
    }
  }

  _glogout() async {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

//  _flogin() async {
//    final result = await facebookLogin.logIn(['email']);
////
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final token = result.accessToken.token;
//        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//        final profile = JSON.jsonDecode(graphResponse.body);
//        print(profile);
//        setState(() {
//          userProfile = profile;
//          _isLoggedIn = true;
//        });
//        break;
////
//      case FacebookLoginStatus.cancelledByUser:
//        setState(() => _isLoggedIn = false);
//        break;
//      case FacebookLoginStatus.error:
//        setState(() => _isLoggedIn = false);
//        break;
//    }
//  }
////
//    _flogout() {
//      facebookLogin.logOut();
//      setState(() {
//        _isLoggedIn = false;
//      });
//    }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(
                'https://www.setaswall.com/wp-content/uploads/2019/02/Xiaomi-Mi-9-Stock-Wallpaper-16-1080x2340.jpg'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: _isLoggedIn
              ?
//            Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterWidget()))
//
//
//
//
//              Container(
//                // child: Text(_googleSignIn.currentUser.email),
//              ),
//              RaisedButton(
//                child: Text("Google Logout"),
//                onPressed: () {
//                  _glogout();
//                },
//              ),
//              RaisedButton(
//                child: Text(" Facebook Logout"),
//                onPressed: () {
//                  _glogout();
//                },
//              ),
//
//             ],
//            )

              : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(
                        children: <Widget>[
                          new Image.asset(
                            'assets/images/banner_white.png',
                            height: 62,
                            width: 322,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text("Hello World, Bye",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),

                            ),

                          )

                        ]
                    )
                ),
                Container(margin: const EdgeInsets.only(top: 70.0)),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      _glogin();
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(topRight: Radius
                          .circular(25.0), bottomLeft: Radius.circular(
                          25.0), bottomRight: Radius.circular(25.0)),
                    ),
                    child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: new Image.asset(
                              'assets/images/google2.png',
                              height: 30,
                              width: 80,
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: new Text(
                              'Sign-In with Google',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
                Container(
                    margin:
                    const EdgeInsets.only(bottom: 20.0, top: 20.0)),
                Center(
                    child: RaisedButton(
                        onPressed: () {
                          _glogin();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                        ),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: new Image.asset(
                                  'assets/images/facebook.png',
                                  height: 30,
                                  width: 80,
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: new Text(
                                  'Sign-In with Facebook',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ])))
              ]),
        ),
      ),
    );
  }
}