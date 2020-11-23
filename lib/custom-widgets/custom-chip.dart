import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {

  String labelText ;
  Color bgColor;


  CustomChip(this.labelText, this.bgColor);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label : Text(
        labelText,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(13),
              bottomRight: Radius.circular(13),
              bottomLeft: Radius.circular(13)
          )
      ),
      elevation: 2,
      backgroundColor: bgColor,
    );
  }
}
