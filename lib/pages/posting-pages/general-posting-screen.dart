
import 'dart:io';
import 'package:Bubble/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class GeneralPostingScreen extends StatefulWidget {
  @override
  _GeneralPostingScreenState createState() => _GeneralPostingScreenState();
}

class _GeneralPostingScreenState extends State<GeneralPostingScreen> {

  CrudMethods crudMethods = new CrudMethods();

  File imageFile;
  bool _isLoading = false;

  String caption;


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

      Map<String,String> postMap ={
        "caption": caption,
        "userName": "Anon", // need to get from auth
        "userHandle": "astro", // need to get from db
        "activityName": "",
        "when": "",
        "where": "",
        "tagName": "General", // get from fab click
        "avatarUrl": "https://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg", // need to get from auth
        "imageUrl": downloadUrl,
        "liked": "false",
        "likes": "0",
        "timeStamp": "morning", // need to generate here

        "option1Text": "-1",
        "option2Text": "-1",
        "option3Text": "-1",
        "option4Text": "-1",
        "option1Count" : "-1",
        "option2Count" : "-1",
        "option3Count" : "-1",
        "option4Count" : "-1",
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
        title: Text("Post Lost&Found"),
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
                    /*Caption*/
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Give a brief",
                          labelText: "Caption",
                          icon: Icon(Icons.title)
                      ),
                      onChanged: (value){
                        caption = value;
                      },
                    ),
                    SizedBox(height: 16,),

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


