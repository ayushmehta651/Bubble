import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addPost(postData) async {
    FirebaseFirestore.instance.collection("post").add(postData).catchError((e) {
      print(e);
    });
  }

  getPost() async {
    return FirebaseFirestore.instance.collection("post").snapshots();
  }

  updateCount(int value, int updatedCount, String uid) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('post');
    return await ref
        .doc(uid)
        .update({"option${value}Count": updatedCount})
        .then((value) => print("success"))
        .catchError((error) => print(error.toString()));
  }
}
