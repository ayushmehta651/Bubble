import './browse.dart';
import 'package:Bubble/custom-widgets/activityCard.dart';
import 'package:Bubble/custom-widgets/generalCard.dart';
import 'package:Bubble/custom-widgets/lostAndFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'models/Post.dart';
import 'package:line_icons/line_icons.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // Back-end guys fetch data and put it here
  List<Post2> mPosts = [
    Post2(
        caption: "This is a caption",
        userName: "Ajay Galagali",
        userHandle: "astro",
        activityName: "If non-null, the itemExtent forces the children to have the given extent in the scroll direction. Specifying an itemExtent is more efficient than letting the children determine their own extent because the scrolling machinery can make use of the foreknowledge of the children's extent to save work, for example when the scroll position changes drastically.",
        when: "Yesterday",
        where: "ISE Dept",
        tagName: "L&F",
        avatarUrl: "https://lh3.googleusercontent.com/ogw/ADGmqu8V283QJ4mY86zg6eHzkXjFaS77U-rpadqu2-p2Ng=s32-c-mo",
        imageUrl: "https://i.ytimg.com/vi/hF_LjTUvP-U/maxresdefault.jpg",
        likes: 20,
        liked: true,
        timeStamp: "moments ago"
    ),
    Post2(
        userName: "Ajay Galagali",
        userHandle: "astro",
        activityName: "You will need to check your return from database, to verify if it's null. By the error, Flutter is indicating that you are working with null values. As @ShubhamGupta mentioned, please, add a exception treatment to your code, to verify better the error",
        when: "Jan 1st",
        caption: "You will need to check your return from database, to verify if it's null. By the error, Flutter is indicating that you are working with null values. As @ShubhamGupta mentioned, please, add a exception treatment to your code, to verify better the error",
        where: "Ooty",
        tagName: "Activity",
        avatarUrl: "https://lh3.googleusercontent.com/ogw/ADGmqu8V283QJ4mY86zg6eHzkXjFaS77U-rpadqu2-p2Ng=s32-c-mo",
        imageUrl: "https://i.ytimg.com/vi/hF_LjTUvP-U/maxresdefault.jpg",
        likes: 20,
        liked: true,
        timeStamp: "moments ago"
    ),
    Post2(
        userName: "Ajay Galagali",
        userHandle: "astro",
        caption: "You will need to check your return from database, to verify if it's null. By the error, Flutter is indicating that you are working with null values. As @ShubhamGupta mentioned, please, add a exception treatment to your code, to verify better the error",
        tagName: "General",
        avatarUrl: "https://lh3.googleusercontent.com/ogw/ADGmqu8V283QJ4mY86zg6eHzkXjFaS77U-rpadqu2-p2Ng=s32-c-mo",
        imageUrl: "https://i.ytimg.com/vi/hF_LjTUvP-U/maxresdefault.jpg",
        likes: 20,
        liked: true,
        timeStamp: "moments ago"
    ),
  ];

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
      backgroundColor: Color(0xFFEBF2FA),
      body:Column(

        children: [

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),

            // Tags ChipCards

            child: SingleChildScrollView(
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text('All'),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    selected: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            bottomRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13)
                        )
                    ),
                    elevation: 2,
                    selectedColor: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    label: Text('Activity'),
                    selected: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            bottomRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13)
                        )
                    ),
                    elevation: 2,
                    selectedColor: Colors.yellow[900],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    label: Text('Poll'),
                    selected: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            bottomRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13)
                        )
                    ),
                    elevation: 2,
                    selectedColor: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    label: Text('L&F'),
                    selected: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            bottomRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13)
                        )
                    ),
                    elevation: 2,
                    onSelected: (selected){
                      // print("isSelected->$isSelected");
                      // _selected = !_selected;
                    },
                    selectedColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),

          // Populating Posts

          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-165,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: mPosts.map((e) => giveMeWidget(e)).toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),


    );
  }

  // Returns card template according to tag of post
  Widget giveMeWidget(Post2 curPost){
    
    if(curPost.tagName == "Activity"){
      return ActivityCard(
        post: curPost,
      );
    }else if(curPost.tagName == "L&F"){
      return LostAndFoundPost(
        post: curPost,
      );
    }else if(curPost.tagName == "General"){
      return GeneralCard(
        post: curPost,
      );
    }
    
  }
}


