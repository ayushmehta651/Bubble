import 'package:Bubble/custom-widgets/activityCard.dart';
import 'package:Bubble/custom-widgets/generalCard.dart';
import 'package:Bubble/custom-widgets/lostAndFound.dart';
import 'package:Bubble/custom-widgets/poll-card.dart';
import 'package:Bubble/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Post post = Post(
    caption: "Caption",
    userName: "Username", // need to get from auth
    userHandle: "Handle", // need to get from db
    activityName: "ActName",
    when: "When",
    where: "Where",
    tagName: "Act", // get from fab click
    avatarUrl:
        "https://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg", // need to get from auth
    imageUrl:
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",
    liked: false,
    likes: 0,
    timeStamp: "Timestamp", // need to generate here
    option1Text: "option1",
    option2Text: "option2",
    option3Text: "option3",
    option4Text: "option4",
    option1Count: 12,
    option2Count: 5,
    option3Count: 23,
    option4Count: 15,
  );

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  /* Activity Card Test */
  testWidgets('activity-card-test', (WidgetTester tester) async {
    ActivityCard activityCard = ActivityCard(
      post: post,
    );

    await mockNetworkImagesFor(() async =>
        await tester.pumpWidget(makeTestableWidget(child: activityCard)));
    expect(find.text("Caption"), findsOneWidget);
    expect(find.text("Act"), findsOneWidget);
    expect(find.text("Username"), findsOneWidget);
    expect(find.text(" @Handle"), findsOneWidget);
    expect(find.text("ActName"), findsOneWidget);
    expect(find.text("When"), findsOneWidget);
    expect(find.text("Where"), findsOneWidget);
  });

  /* General Card Test */
  testWidgets('general-card-test', (WidgetTester tester) async {
    GeneralCard generalCard = GeneralCard(
      post: post,
    );

    await mockNetworkImagesFor(() async =>
        await tester.pumpWidget(makeTestableWidget(child: generalCard)));
    expect(find.text("Caption"), findsOneWidget);
    expect(find.text("Act"), findsOneWidget);
    expect(find.text("Username"), findsOneWidget);
    expect(find.text(" @Handle"), findsOneWidget);
  });

  /* Lost&Found Card Test */
  testWidgets('lost&found-card-test', (WidgetTester tester) async {
    LostAndFoundPost activityCard = LostAndFoundPost(
      post: post,
    );

    await mockNetworkImagesFor(() async =>
        await tester.pumpWidget(makeTestableWidget(child: activityCard)));
    expect(find.text("Caption"), findsOneWidget);
    expect(find.text("Act"), findsOneWidget);
    expect(find.text("Username"), findsOneWidget);
    expect(find.text(" @Handle"), findsOneWidget);
    expect(find.text("ActName"), findsOneWidget);
    expect(find.text("When"), findsOneWidget);
    expect(find.text("Where"), findsOneWidget);
  });

  /* Polling Card Test */
  testWidgets('polling-card-test', (WidgetTester tester) async {
    PollCard activityCard = PollCard(
      post: post,
    );

    await mockNetworkImagesFor(() async =>
        await tester.pumpWidget(makeTestableWidget(child: activityCard)));
    expect(find.text("Caption"), findsOneWidget);
    expect(find.text("Username"), findsOneWidget);
    expect(find.text(" @Handle"), findsOneWidget);
    expect(find.text("option1"), findsOneWidget);
    expect(find.text("option2"), findsOneWidget);
    expect(find.text("option3"), findsOneWidget);
    expect(find.text("option4"), findsOneWidget);

    await tester.tap(find.text("option1"));
    await tester.pump();

    expect(find.text("22%"), findsOneWidget);
    expect(find.text("9%"), findsOneWidget);
    expect(find.text("42%"), findsOneWidget);
    expect(find.text("27%"), findsOneWidget);
  });
}
