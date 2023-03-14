import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/services/auth.dart';

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

  static Stream<List<MyUser>> getUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapshot) => snapshot.docs
            .map<MyUser>((doc) => MyUser.fromJson(doc.data()))
            .toList());
  }

  static Future<void> updateUser(
      {required String userId,
      required String field,
      required dynamic value}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    final json = {
      'userId': docUser.id,
      field: value,
    };

    await docUser.update(json).then((value) => logger.i('User updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  static Future<void> updateUserExplanation(
      {required String userId, required String explanation}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    final json = {
      'userId': docUser.id,
      'userExplanation': explanation,
    };

    // create document and write data to Firebase
    await docUser.update(json).then(
        (value) => logger.i('User Explanation updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  static Future<void> updateUserEmail(
      {required String userId, required String email}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    final json = {
      'userId': docUser.id,
      'userEmail': email,
    };

    // create document and write data to Firebase
    await docUser.update(json).then((value) => logger.i('User Email updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  /// Notice this method do not update the Post model user name field
  static Future<void> updateUserName(
      {required String userId, required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    final json = {
      'userId': docUser.id,
      'userName': name,
    };

    // create document and write data to Firebase
    await docUser.update(json).then((value) => logger.i('User Name updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  /// This method do not sign out the user
  static Future<void> deleteUser({required String userId}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    await docUser.delete().then((value) => logger.i('User deleted'),
        onError: (error) => logger.e('Failed to delete user: $error'));
  }
}
