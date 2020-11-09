import 'package:bubble/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Bubble());

class Bubble extends StatelessWidget {
  const Bubble({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bubble',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
