import 'package:flutter/material.dart';
import '../common/utils.dart';
import '../widgets/activity_tiles.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _screen.height,
        width: _screen.width,
        color: Color(0XFFEBF2FA),
        child: ListView(
          children: <Widget>[
            ListTile(
                leading: Text('This Week',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[850],
                        fontSize: 16))),
            followActivityTile(
                context: context,
                followerUsername: 'tenzin_choekyi',
                followerImageUrl: Utils.getRandomImageUrl(),
                isFollowed: false),
            commnetActivityTIle(
                isMention: true,
                otherUsername: 'ttruselph',
                otherUserProfileImageUrl: Utils.getRandomImageUrl(),
                comment: 'jpt journalist n jpt reporting',
                commentedOnMediaUrl: Utils.getRandomImageUrl()),
            followActivityTile(
                context: context,
                followerUsername: 'gyalmo20',
                followerImageUrl: Utils.getRandomImageUrl()),
            commnetActivityTIle(
                isMention: true,
                comment: '😂',
                otherUsername: 'codepower.io',
                otherUserProfileImageUrl: Utils.getRandomImageUrl(),
                commentedOnMediaUrl: Utils.getRandomImageUrl()),
            commnetActivityTIle(
                isMention: false,
                comment:
                    'Haha. One that fools around a lot but gets there workd done some how. 😂😂😂',
                otherUsername: 'codepower.io',
                otherUserProfileImageUrl: Utils.getRandomImageUrl(),
                commentedOnMediaUrl: Utils.getRandomImageUrl()),
            Divider(color: Colors.grey[850]),
            ListTile(
                leading: Text('This Month',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[850],
                        fontSize: 16))),
            likedOnPost(
              likedUsernames:
                  List.generate(100000, (index) => 'apple${index.toString()}'),
              postUrl: Utils.getRandomImageUrl(),
              likedUserImageUrls:
                  List.generate(2, (index) => Utils.getRandomImageUrl()),
            ),
            followActivityTile(
                context: context,
                followerUsername: 'himani_mudgil',
                followerImageUrl: Utils.getRandomImageUrl(),
                isFollowed: true),
            followActivityTile(
                context: context,
                followerUsername: 'ngawang_94',
                followerImageUrl: Utils.getRandomImageUrl(),
                isFollowed: true),
            followActivityTile(
                context: context,
                followerUsername: 'thokmey_tenzi',
                followerImageUrl: Utils.getRandomImageUrl()),
          ],
        ),
      ),
    );
  }
}
