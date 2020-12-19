import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

import '../homePage.dart';
import '../homePage.dart';
import '../homePage.dart';
import '../profile.dart';
import '../profile.dart';
import '../profile.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _auth = FirebaseAuth.instance;
  String id;
  String image =
      'https://th.bing.com/th/id/OIP.Jf0NnGpH2AhNM3BtwZufwwHaJ4?w=131&h=180&c=7&o=5&dpr=1.25&pid=1.7';
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController interests = TextEditingController();
  TextEditingController branch = TextEditingController();
  File _image;
  final picker = ImagePicker();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Details "),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "😀 We want know to more about you 😀",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    getimage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 75,
                    child: ClipOval(
                      child: SizedBox(
                        height: 140,
                        width: 140,
                        child: (_image != null)
                            ? Image.file(_image, fit: BoxFit.fill)
                            : Image.network(image, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: "What do your friends call you? ",
                      labelText: "Nickname",
                      icon: Icon(Icons.account_circle)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: "Some words about you ",
                      labelText: "Bio",
                      icon: Icon(Icons.chat_bubble_outline)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: interests,
                  decoration: InputDecoration(
                      hintText: "What you love to do? ",
                      labelText: "Interests",
                      icon: Icon(Icons.star)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: branch,
                  decoration: InputDecoration(
                      hintText: "Divided by branches, united by Engineering",
                      labelText: "Branch",
                      icon: Icon(Icons.account_tree)),
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton.icon(
                  onPressed: () async {
                    uploadpost();
                    await create().whenComplete(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(id: id)));
                    });
                  },
                  icon: Icon(Icons.arrow_right),
                  label: Text("Get Started"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(13),
                          bottomRight: Radius.circular(13),
                          bottomLeft: Radius.circular(13))),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(right: 24, top: 16, bottom: 16),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> create() async {
    final docref = await FirebaseFirestore.instance.collection("profile").add({
      'name': name.text,
      'description': description.text,
      'interests': interests.text,
      'branch': branch.text,
      'image': image,
    });
    id = docref.id;
    print(id);
    print(image);
  }
}
