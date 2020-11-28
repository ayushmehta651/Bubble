
import 'dart:io';
import 'package:Bubble/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ActivityPostingScreen extends StatefulWidget {
  @override
  _ActivityPostingScreenState createState() => _ActivityPostingScreenState();
}

class _ActivityPostingScreenState extends State<ActivityPostingScreen> {

  CrudMethods crudMethods = new CrudMethods();

  File imageFile;
  bool _isLoading = false;

  String caption;
  String activityName;
  String when;
  String where;

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
        "activityName": activityName,
        "when": when,
        "where": where,
        "tagName": "Activity", // get from fab click
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

      /*Post post = Post(
        caption: caption,
        userName: "Anon", // need to get from auth
        userHandle: "astro", // need to get from db
        activityName: activityName,
        when: when,
        where: where,
        tagName: "Activity", // get from fab click
        avatarUrl: "xyz", // need to get from auth
        imageUrl: downloadUrl,
        liked: false,
        likes: 0,
        timeStamp: "morning" // need to generate here
      );*/

      crudMethods.addPost(postMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Post Activity"),
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
                      /*Activity Name*/
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "What activity would you like to do?",
                            labelText: "Activity Name",
                            icon: Icon(Icons.star)
                        ),
                        onChanged: (value){
                          activityName = value;
                        },
                      ),
                      SizedBox(height: 16,),
                      /*When*/
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Date and time of this activity",
                            labelText: "When",
                            icon: Icon(Icons.calendar_today)
                        ),
                        onChanged: (value){
                          when = value;
                        },
                      ),
                      SizedBox(height: 16,),

                      /*Where*/
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "What activity would you like to do?",
                            labelText: "Where",
                            icon: Icon(Icons.location_pin)
                        ),
                        onChanged: (value){
                          where = value;
                        },
                      ),
                      SizedBox(height: 16,),

                      /*Caption*/
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Give a brief about your plans",
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


/*
*
*
* child: Column(
          children: [
            /*Input fields*/
            Form(
              child: Column(
                children: [

                  /*Activity Name*/
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "What activity would you like to do?",
                      labelText: "Activity Name",
                      icon: Icon(Icons.star)
                    ),
                  ),
                  SizedBox(height: 16,),
                  /*When*/
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Date and time of this activity",
                      labelText: "When",
                      icon: Icon(Icons.calendar_today)
                    ),
                  ),
                  SizedBox(height: 16,),

                  /*Where*/
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "What activity would you like to do?",
                      labelText: "Where",
                      icon: Icon(Icons.location_pin)
                    ),
                  ),
                  SizedBox(height: 16,),

                  /*Caption*/
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Give a brief about your plans",
                      labelText: "Caption",
                      icon: Icon(Icons.title)
                    ),
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            )

          ],
        ),
*
*
*
* */
