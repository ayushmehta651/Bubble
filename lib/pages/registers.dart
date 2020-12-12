import 'package:Bubble/pages/register-acc-page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final auth = FirebaseAuth.instance;
  bool show = true;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new NetworkImage(
              'https://www.setaswall.com/wp-content/uploads/2019/02/Xiaomi-Mi-9-Stock-Wallpaper-16-1080x2340.jpg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Container(
                  child: Column(children: <Widget>[
                new Image.asset(
                  'assets/banner_white.png',
                  height: 62,
                  width: 322,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "Hello World, Bye",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                )
              ])),
              Container(margin: const EdgeInsets.only(top: 70.0)),
              Center(
                child: RaisedButton(
                  onPressed: () async {
                    await signingoogle().whenComplete(() =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterWidget())));
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
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
                            'assets/google.png',
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
              Container(margin: const EdgeInsets.only(bottom: 20.0, top: 20.0)),
              Center(
                  child: RaisedButton(
                      onPressed: () async {
                        final FacebookLoginResult result = await facebookSignIn
                            .logIn(['email']).whenComplete(() =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterWidget())));

                        switch (result.status) {
                          case FacebookLoginStatus.loggedIn:
                            final FacebookAccessToken accessToken =
                                result.accessToken;
                            print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
                            break;
                          case FacebookLoginStatus.cancelledByUser:
                            print('Login cancelled by the user.');
                            break;
                          case FacebookLoginStatus.error:
                            print(
                                'Something went wrong with the login process.\n'
                                'Here\'s the error Facebook gave us: ${result.errorMessage}');
                            break;
                        }
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
                              child: new Image.network(
                                'https://www.freepnglogos.com/uploads/facebook-icons/facebook-icon-transparent-background-3.png',
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
      ),
    );
  }

  Future<User> signingoogle() async {
    final googleSignin = GoogleSignIn();
    final account = await googleSignin.signIn();
    if (account != null) {
      GoogleSignInAuthentication googleAuth = await account.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final result = await auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return result.user;
      }
    }
  }
}
