import 'package:flutter/material.dart';

class BrowseApp extends StatefulWidget {
  @override
  _BrowseAppState createState() => _BrowseAppState();
}

class _BrowseAppState extends State<BrowseApp> {
  bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Color(0XFFEBF2FA);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColors(),
          elevation: 0,
          brightness: themeSwitch ? Brightness.dark : Brightness.light,
          leading: IconButton(
            onPressed: () {
              setState(() {
                themeSwitch = !themeSwitch;
              });
            },
            icon: themeSwitch
                ? Icon(
                    Icons.brightness_3,
                    color: themeSwitch ? Color(0XFFEBF2FA) : Colors.grey[850],
                  )
                : Icon(
                    Icons.wb_sunny,
                    color: themeSwitch ? Color(0XFFEBF2FA) : Colors.grey[850],
                  ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: themeColors(),
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: themeColors(),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30.0),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(

                              topRight: Radius.circular(25.0),
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: themeSwitch
                              ? Color(0XFFEBF2FA)
                              : Colors.grey[850],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 200.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            imageCard("1", "Landscape"),
                            imageCard("2", "Architecture"),
                            imageCard("3", "Animal"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/4.jpeg"),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Current Festival",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget imageCard(image, title) {
  return AspectRatio(
    aspectRatio: 2.5 / 3,
    child: Container(
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/$image.jpeg"),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
