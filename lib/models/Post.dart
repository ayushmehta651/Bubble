class Post {
  String caption;
  String userName;
  String userHandle;
  String activityName;
  String when;
  String where;
  String tagName;
  String avatarUrl;
  String imageUrl;
  String uid;
  int likes;
  bool liked;
  String timeStamp;

  String option1Text;
  String option2Text;
  String option3Text;
  String option4Text;

  int option1Count;
  int option2Count;
  int option3Count;
  int option4Count;

  Post(
      {this.caption,
      this.userName,
      this.userHandle,
      this.activityName,
      this.when,
      this.where,
      this.tagName,
      this.avatarUrl,
      this.imageUrl,
      this.likes,
      this.liked,
      this.timeStamp,
      this.option1Text,
      this.option2Text,
      this.option3Text,
      this.option4Text,
      this.option1Count,
      this.option2Count,
      this.option3Count,
      this.option4Count,
      this.uid});
}
