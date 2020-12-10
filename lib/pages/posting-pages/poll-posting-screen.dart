import 'package:Bubble/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class PollPostingScreen extends StatefulWidget {
  @override
  _PollPostingScreenState createState() => _PollPostingScreenState();
}

class _PollPostingScreenState extends State<PollPostingScreen> {
  CrudMethods crudMethods = new CrudMethods();

  bool _isLoading = false;

  String caption;
  String option1;
  String option2;
  String option3;
  String option4;
  String uid;

  uploadPost() async {
    setState(() {
      _isLoading = true;
    });

    CollectionReference ref = FirebaseFirestore.instance.collection('post');
    var temp = "";
    temp = "${randomAlphaNumeric(20)}";
    print(temp);
    ref.doc(temp).set({
      "uid": temp,
      "caption": caption,
      "userName": "AjayG", // need to get from auth
      "userHandle": "astro", // need to get from db
      "activityName": "-1",
      "when": "-1",
      "where": "-1",
      "tagName": "Poll", // get from fab click
      "avatarUrl":
          "https://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg", // need to get from auth
      "imageUrl": "-1",
      "liked": "false",
      "likes": "0",
      "timeStamp": "morning", // need to generate here
      "option1Text": option1,
      "option2Text": option2,
      "option3Text": option3,
      "option4Text": option4,
      "option1Count": 0,
      "option2Count": 0,
      "option3Count": 0,
      "option4Count": 0,
    }).then((value) => Navigator.pop(context));

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
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          /*Question*/
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Describe your poll",
                                labelText: "Question",
                                icon: Icon(Icons.question_answer)),
                            onChanged: (value) {
                              caption = value;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),

                          /*Option 1*/
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Option 1",
                                labelText: "Option 1",
                                icon: Icon(Icons.looks_one_outlined)),
                            onChanged: (value) {
                              option1 = value;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),

                          /*Option 2*/
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Option 2",
                                labelText: "Option 2",
                                icon: Icon(Icons.looks_two_outlined)),
                            onChanged: (value) {
                              option2 = value;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),

                          /*Option 3*/
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Option 3",
                                labelText: "Option 3",
                                icon: Icon(Icons.looks_3_outlined)),
                            onChanged: (value) {
                              option3 = value;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),

                          /*Option 4*/
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Option 4",
                                labelText: "Option 4",
                                icon: Icon(Icons.looks_4_outlined)),
                            onChanged: (value) {
                              option4 = value;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
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
