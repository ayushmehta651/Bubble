import 'package:flutter/material.dart';
import './screens/activity_screen.dart';

class InstagramMain extends StatelessWidget {
  const InstagramMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram UI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue[350],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ActivityScreen(),
    );
  }
}
