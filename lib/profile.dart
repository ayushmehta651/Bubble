import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final image = new TextEditingController();
  final username = new TextEditingController();
  final phone = new TextEditingController();
  final password = new TextEditingController();
  final hobbies = new TextEditingController();
  File _image;
  Future getimage() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image1;
    });
  }

  uploadpost() async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("profile")
        .child("${randomAlphaNumeric(9)}.jpg");
    final UploadTask task = firebaseStorageRef.putFile(_image);
    var downloadurl = await (await task.whenComplete(() => print('hello')))
        .ref
        .getDownloadURL();
    image.text = downloadurl;
    print(downloadurl);
    print(image.text);
  }

  bool show = true;
  List tags = [];
  bool darktheme = false;

  @override
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('account')
        .where('username', isEqualTo: 'Pragna')
        .get()
        .then((snapshot) {
      if (snapshot != null) {
        snapshot.docs.forEach((element) {
          username.text = element.data()['username'];
          password.text = element.data()['password'];
          phone.text = element.data()['phone'];
          hobbies.text = element.data()['hobbies'];
          image.text = element.data()['image'];
          print(username.text);
          print(password.text);
          print(phone.text);
          print(hobbies.text);
          print(image.text);
        });
      } else {
        print('Data is Loading');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darktheme ? Colors.grey[850] : Color(0xffebf2fa),
      appBar: AppBar(
        backgroundColor: darktheme ? Colors.grey[850] : Color(0xffebf2fa),
        elevation: 1,
        leading: Switch(
          activeColor: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
          value: darktheme,
          onChanged: (changedtheme) {
            setState(() {
              darktheme = changedtheme;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(left: 16.0, top: 25.0, right: 16.0),
          child: ListView(
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat-SemiBold',
                  color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  getimage();
                },
                child: CircleAvatar(
                  backgroundColor:
                      darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                  radius: 90,
                  child: ClipOval(
                    child: SizedBox(
                      height: 170,
                      width: 170,
                      child: (_image != null)
                          ? Image.file(_image, fit: BoxFit.fill)
                          : Image.network(image.text, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  cursorColor: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                  controller: username,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Full name",
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat-SemiBold',
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                    ),
                    hintText: username.text,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  cursorColor: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                  controller: phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Number",
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat-SemiBold',
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                    ),
                    hintText: phone.text,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  cursorColor: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                  controller: password,
                  obscureText: show,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat-SemiBold',
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                    ),
                    hintText: password.text,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: TextField(
                  cursorColor: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                  controller: hobbies,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Interests",
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat-SemiBold',
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                    ),
                    hintText: hobbies.text,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      fontFamily: 'Montserrat-SemiBold',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      onPressed: () {},
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 14.0,
                          color:
                              darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                          fontFamily: 'Montserrat-SemiBold',
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                      onPressed: () {
                        uploadpost();
                        ok(username.text, password.text, phone.text,
                            hobbies.text, image.text);
                      },
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: darktheme ? Colors.grey[850] : Colors.white,
                          fontFamily: 'Montserrat-SemiBold',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> ok(String text1, String text2, String text3, String text4,
      String text5) async {
    await Firebase.initializeApp();

    CollectionReference ref = FirebaseFirestore.instance.collection('account');
    ref.doc('5678').update({
      'username': username.text,
      'password': password.text,
      'phone': phone.text,
      'hobbies': hobbies.text,
      'image': image.text,
    }).then((value) {
      print(username.text);
      print(image.text);
    });
  }
}