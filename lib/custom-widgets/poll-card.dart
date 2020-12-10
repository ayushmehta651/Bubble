import 'package:Bubble/models/Post.dart';
import 'package:Bubble/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'custom-chip.dart';

class PollCard extends StatefulWidget {
  Post post;
  Function likeClicked;
  bool isEnabled = true;
  // Function pollBtnClick;
  String per1 = " ";
  String per2 = " ";
  String per3 = " ";
  String per4 = " ";

  PollCard({this.post, this.likeClicked});

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  Color primaryColor = Colors.green;
  CrudMethods _crudMethods = CrudMethods();

  Future<void> changeState(int value) async {
    int oneCount = widget.post.option1Count;
    int twoCount = widget.post.option2Count;
    int threeCount = widget.post.option3Count;
    int fourCount = widget.post.option4Count;

    if (value == 0) {
      await _crudMethods.updateCount(
          value + 1, widget.post.option1Count + 1, widget.post.uid);
      setState(() {
        oneCount += 1;
      });
    } else if (value == 1) {
      await _crudMethods.updateCount(
          value + 1, widget.post.option2Count + 1, widget.post.uid);
      setState(() {
        twoCount += 1;
      });
    } else if (value == 2) {
      await _crudMethods.updateCount(
          value + 1, widget.post.option3Count + 1 + 1, widget.post.uid);
      setState(() {
        threeCount += 1;
      });
    } else if (value == 3) {
      await _crudMethods.updateCount(
          value + 1, widget.post.option4Count + 1 + 1, widget.post.uid);
      setState(() {
        fourCount += 1;
      });
    }

    var totalCount = oneCount + twoCount + threeCount + fourCount;
    print(" One $oneCount + Two  $twoCount + Three $threeCount = $fourCount");
    print("Total Count -> $totalCount");

    var onePercentage = (oneCount / totalCount) * 100;
    var twoPercentage = (twoCount / totalCount) * 100;
    var threePercentage = (threeCount / totalCount) * 100;
    var fourPercentage = (fourCount / totalCount) * 100;

    setState(() {
      widget.isEnabled = false;
      widget.per1 = "${onePercentage.round()}%";
      widget.per2 = "${twoPercentage.round()}%";
      widget.per3 = "${threePercentage.round()}%";
      widget.per4 = "${fourPercentage.round()}%";
    });
    print("1 % -> ${onePercentage.round()}");
    print("2 % -> ${twoPercentage.round()}");
    print("3 % -> ${threePercentage.round()}");
    print("4 % -> ${fourPercentage.round()}");
  }

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
                          backgroundImage: NetworkImage(widget.post.avatarUrl),
                          radius: 16,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        widget.post.userName,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' @${widget.post.userHandle}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // TagName
            Expanded(
              flex: 2,
              child: Column(
                children: [CustomChip(widget.post.tagName, primaryColor)],
              ),
            ),
          ],
        ),
        // Icons and Text
        Row(
          children: [
            Expanded(
              child: AbsorbPointer(
                absorbing: !widget.isEnabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.caption,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    PollButton(
                      label: widget.post.option1Text,
                      percentage: widget.per1,
                      btnIcon: Icons.looks_one_outlined,
                      onClick: () {
                        changeState(0);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    PollButton(
                      label: widget.post.option2Text,
                      percentage: widget.per2,
                      btnIcon: Icons.looks_two_outlined,
                      onClick: () {
                        changeState(1);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    PollButton(
                      label: widget.post.option3Text,
                      percentage: widget.per3,
                      btnIcon: Icons.looks_3_outlined,
                      onClick: () {
                        changeState(2);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    PollButton(
                      label: widget.post.option4Text,
                      percentage: widget.per4,
                      btnIcon: Icons.looks_4_outlined,
                      onClick: () {
                        changeState(3);
                      },
                    ),
                    SizedBox(
                      height: 8,
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
                                  // Like Button
                                  IconButton(
                                      icon: widget.post.liked
                                          ? Icon(
                                              LineIcons.heart,
                                              color: Colors.red,
                                            )
                                          : Icon(LineIcons.heart_o),
                                      onPressed: widget.likeClicked),
                                  Text('${widget.post.likes}'),
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
                            children: [Text(widget.post.timeStamp)],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}

class PollButton extends StatefulWidget {
  String label;
  IconData btnIcon;
  Function onClick;
  String percentage;
  PollButton({this.label, this.percentage, this.btnIcon, this.onClick});

  @override
  _PollButtonState createState() => _PollButtonState();
}

class _PollButtonState extends State<PollButton> {
  Color btnColor = Colors.transparent;

  void mClick() {
    setState(() {
      btnColor = Colors.greenAccent;
      print("Changed color");
    });
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 50,
      child: FlatButton(
          color: btnColor,
          child: Align(
              // alignment: Alignment.centerLeft,
              child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(widget.btnIcon),
                        SizedBox(
                          width: 16,
                        ),
                        Text(widget.label),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(widget.percentage)
                  ],
                ),
              )
            ],
          )),
          onPressed: () {
            mClick();
          }),
    );
  }
}
