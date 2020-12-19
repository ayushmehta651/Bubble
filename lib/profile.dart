import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  String id;
  Profile({this.id});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String image;
  final username = new TextEditingController();
  final description = new TextEditingController();
  final interests = new TextEditingController();
  final branch = new TextEditingController();
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
    image = downloadurl;
    print(downloadurl);
    print(image);
  }

  bool show = true;
  List tags = [];
  bool darktheme = false;

  @override
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('profile')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot snapshot) {
      username.text = snapshot['name'];
      description.text = snapshot['description'];
      interests.text = snapshot['interests'];
      branch.text = snapshot['branch'];
      image = snapshot['image'];
    });
    print(username.text);
    print(description.text);
    print(interests.text);
    print(branch.text);
    print(image);
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('profile')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('no data');
            }
            var user = snapshot.data;
            return GestureDetector(
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
                                : Image.network(user['image'],
                                    fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        cursorColor:
                            darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                        controller: username,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Full name",
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                          ),
                          hintText: user['name'],
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                            fontFamily: 'Montserrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        cursorColor:
                            darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                        controller: description,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Bio",
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                          ),
                          hintText: user['description'],
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                            fontFamily: 'Montserrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: TextField(
                        cursorColor:
                            darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                        controller: interests,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Interests",
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                          ),
                          hintText: user['interests'],
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                            fontFamily: 'Montserrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        cursorColor:
                            darktheme ? Color(0xffebf2fa) : Colors.grey[850],
                        controller: branch,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Branch",
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                          ),
                          hintText: user['branch'],
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                            fontFamily: 'Montserrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
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
                                color: darktheme
                                    ? Color(0xffebf2fa)
                                    : Colors.grey[850],
                                fontFamily: 'Montserrat-SemiBold',
                              ),
                            ),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: darktheme
                                ? Color(0xffebf2fa)
                                : Colors.grey[850],
                            onPressed: () async {
                              uploadpost();
                              await ok(username.text, description.text,
                                  interests.text, branch.text, image);
                            },
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    darktheme ? Colors.grey[850] : Colors.white,
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
            );
          }),
    );
  }

  Future<void> ok(String text1, String text2, String text3, String text4,
      String text5) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('profile');
    ref.doc(widget.id).update({
      'username': username.text,
      'description': description.text,
      'interests': interests.text,
      'branch': branch.text,
      'image': image,
    }).then((value) {
      print(username.text);
      print(description.text);
      print(interests.text);
      print(branch.text);
      print(image);
    });
  }
}
