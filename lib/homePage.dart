import 'package:Bubble/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import './Dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  List<Color> colors = [
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.purple,
  ];
  List<Text> text = [
    Text('Feed'),
    Text('Post'),
    Text('Likes'),
    Text('Profile'),

  ];
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bubble'),
      ),
      body:PageView.builder(
        itemCount: 4,
        controller: controller,
        onPageChanged: (page){
          setState(() {
            _index = page;
          });
        },
        itemBuilder: (context,position){
          return Container(
            color: colors[position],
            child: Center(child: text[position]),
          );
        },
      ),

      bottomNavigationBar:SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFEBF2FA),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0,25)
                  )
                ],

              ),
              child: GNav(
                gap: 8,
                curve: Curves.fastOutSlowIn,
                activeColor: Color(0xFFEBF2FA),
                iconSize: 25,
                padding: EdgeInsets.symmetric(horizontal: 20 , vertical : 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.amber,
                tabs: [
                  GButton(
                    icon: LineIcons.home,

                    text: 'Feed',
                  ),
                  GButton(
                    icon: LineIcons.plus_circle,

                    text: 'Post',
                  ),
                  GButton(
                    icon: LineIcons.bell,

                    text: 'Notifications',
                  ),
                  GButton(
                    icon: LineIcons.user,

                    text: 'Profile',
                  ),

                ],
                selectedIndex: _index,
                onTabChange: (index){
                  setState(() {
                    _index = index;
                  });
                  controller.jumpToPage(index);
                  },


              ),
            ),
      ),
    );
  }
}
