import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/user.dart';

class UserDatabaseService {
  static Future<MyUser> createUser(
      {required String uid,
      required String name,
      required String email,
      required String explanation}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final json = {
      'userId': docUser.id,
      'userName': name,
      'userEmail': email,
      'userExplanation': explanation,
    };

    // create document and write data to Firebase
    await docUser.set(json);

    return MyUser(
      userId: docUser.id,
      userName: name,
      userEmail: email,
      userExplanation: explanation,
    );
  }

  static Future<MyUser> getUserById(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => MyUser.fromJson(value.data()!));
  }
}
