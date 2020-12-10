import 'package:Bubble/custom-widgets/poll-card.dart';
import 'package:Bubble/pages/posting-pages/general-posting-screen.dart';
import 'package:Bubble/pages/posting-pages/poll-posting-screen.dart';
import 'package:Bubble/pages/posting-pages/posting-screen-activity.dart';
import 'package:Bubble/pages/posting-pages/posting-screen-lf.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'models/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:Bubble/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Bubble/custom-widgets/activityCard.dart';
import 'package:Bubble/custom-widgets/generalCard.dart';
import 'package:Bubble/custom-widgets/lostAndFound.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CrudMethods crudMethods = new CrudMethods();
  Stream postStreams;

  Widget postList() {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("post").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                return Container(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return giveMeWidget(Post(
                        caption: snapshot.data.docs[index].data()['caption'],
                        userName: snapshot.data.docs[index].data()['userName'],
                        userHandle:
                            snapshot.data.docs[index].data()['userHandle'],
                        activityName:
                            snapshot.data.docs[index].data()['activityName'],
                        when: snapshot.data.docs[index].data()['when'],
                        where: snapshot.data.docs[index].data()['where'],
                        tagName: snapshot.data.docs[index].data()['tagName'],
                        avatarUrl:
                            snapshot.data.docs[index].data()['avatarUrl'],
                        imageUrl: snapshot.data.docs[index].data()['imageUrl'],
                        likes: int.parse(
                            snapshot.data.docs[index].data()['likes']),
                        // liked: snapshot.data.docs[index].data()['liked'],
                        uid: snapshot.data.docs[index].data()['uid'],
                        liked: false,
                        timeStamp:
                            snapshot.data.docs[index].data()['timeStamp'],
                        option1Text:
                            snapshot.data.docs[index].data()['option1Text'],
                        option2Text:
                            snapshot.data.docs[index].data()['option2Text'],
                        option3Text:
                            snapshot.data.docs[index].data()['option3Text'],
                        option4Text:
                            snapshot.data.docs[index].data()['option4Text'],

                        option1Count:
                            snapshot.data.docs[index].data()['option1Count'],
                        option2Count:
                            snapshot.data.docs[index].data()['option2Count'],
                        option3Count:
                            snapshot.data.docs[index].data()['option3Count'],
                        option4Count:
                            snapshot.data.docs[index].data()['option4Count'],
                      ));
                    },
                  ),
                );
              },
            ),
          ),
        )
      ],
    ));
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
      ),
      backgroundColor: Color(0xFFEBF2FA),
      body: postList(),
      floatingActionButton: FabCircularMenu(
        // ringDiameter: MediaQuery.of(context).size.width * 0.5,
        // ringWidth: MediaQuery.of(context).size.width * 0.5,
        ringColor: Colors.black,
        fabOpenColor: Colors.white,
        fabOpenIcon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        children: [
          /*General Post*/
          FlatButton(
            child: Text(
              "General",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeneralPostingScreen()));
            },
          ),

          /*Lost and found post*/
          FlatButton(
            child: Text(
              "L&F",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LostFoundPostingScreen()));
            },
          ),

          /*Activity*/
          FlatButton(
            child: Text(
              "Activity",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityPostingScreen()));
            },
          ),

          /*Poll*/
          FlatButton(
            child: Text(
              "Poll",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PollPostingScreen()));
            },
          ),
        ],
      ),
    );
  }

  // Returns card template according to tag of post
  Widget giveMeWidget(Post curPost) {
    if (curPost.tagName == "Activity") {
      return ActivityCard(
        post: curPost,
      );
    } else if (curPost.tagName == "L&F") {
      return LostAndFoundPost(
        post: curPost,
      );
    } else if (curPost.tagName == "General") {
      return GeneralCard(
        post: curPost,
      );
    } else if (curPost.tagName == "Poll") {
      return PollCard(
        post: curPost,
      );
    }
  }
}
