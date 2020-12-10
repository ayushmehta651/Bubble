import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class RegisterWidget extends StatelessWidget {
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
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://media-exp1.licdn.com/dms/image/C5603AQFMkzo1uC7mRg/profile-displayphoto-shrink_200_200/0?e=1610582400&v=beta&t=tvExMqlfIMaC0AihFtP1zGMj0fFVoiK3FzTiZRgoJGE"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "What do your friends call you? ",
                      labelText: "Nickname",
                      icon: Icon(Icons.account_circle)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Some words about you ",
                      labelText: "Bio",
                      icon: Icon(Icons.chat_bubble_outline)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "What you love to do? ",
                      labelText: "Interests",
                      icon: Icon(Icons.star)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Divided by branches, united by Engineering",
                      labelText: "Branch",
                      icon: Icon(Icons.account_tree)),
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
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
}
