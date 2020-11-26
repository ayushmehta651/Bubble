import 'dart:io';
import 'dart:async';
import 'package:Bubble/browse.dart';
import 'package:Bubble/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:random_string/random_string.dart';

class PostingScreen extends StatefulWidget {
  PostingScreen({Key key}) : super(key: key);

  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  CrudMethods crudMethods = new CrudMethods();

  File imageFile;
  String destination;
  String work;
  bool _isLoading = false;

  _openCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  _openGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              title: Text('Make a Choice!'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _openGallery();
                    },
                    child: Text('Gallery'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera();
                    },
                    child: Text('Camera'),
                  ),
                ],
              )));
        });
  }

  uploadPost() async {
    if (imageFile != null) {
      setState(() {
        _isLoading = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("postImage")
          .child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = firebaseStorageRef.putFile(imageFile);
      var downloadUrl = await (await task.whenComplete(() => print('hello')))
          .ref
          .getDownloadURL();
      Map<String, String> postMap = {
        "imageUrl": downloadUrl,
        "destination": destination,
        "work": work,
      };
      crudMethods.addPost(postMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset('assets/images/banner_white.png'),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: Icon(LineIcons.search),
            onPressed: () {
              BrowseApp();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    imageFile != null
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                _showChoiceDialog();
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                color: Theme.of(context).primaryColor,
                                size: 40.0,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Where Are u heading to?"),
                            onChanged: (val) {
                              destination = val;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "How are u gonna enjoy?"),
                            onChanged: (val) {
                              work = val;
                            },
                          ),
                          SizedBox(height: 10.0),
                          RaisedButton(
                              color: Colors.blue,
                              child: Text("Upload"),
                              onPressed: () {
                                uploadPost();
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
