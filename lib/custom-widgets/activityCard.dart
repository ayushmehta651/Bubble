import 'package:Bubble/custom-widgets/custom-chip.dart';
import 'package:Bubble/models/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ActivityCard extends StatelessWidget {
  Post post;
  Function likeClicked;

  Color primaryColor = Colors.yellow[900];
  ActivityCard({this.post, this.likeClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        // UserDetails and Tag
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(post.avatarUrl),
                          radius: 16,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        post.userName,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' @${post.userHandle}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tag
            Expanded(
              flex: 2,
              child: Column(
                children: [CustomChip(post.tagName, primaryColor)],
              ),
            ),
          ],
        ),

        // Icons and Text
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Caption
                  Text(
                    post.caption,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // ActivityName
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text(post.activityName))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // When
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(post.when)
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // Where
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(post.where)
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // Image of Post
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: NetworkImage(post.imageUrl),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // BottomBar - Like and TimeStamp
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    icon: post.liked
                                        ? Icon(
                                            LineIcons.heart,
                                            color: Colors.red,
                                          )
                                        : Icon(LineIcons.heart_o),
                                    onPressed: likeClicked),
                                Text('${post.likes}'),
                              ],
                            )
                          ],
                        ),
                      ),

                      // TimeStamp
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text(post.timeStamp)],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}