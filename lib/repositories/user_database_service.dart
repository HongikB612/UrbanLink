import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/services/auth.dart';

class UserDatabaseService {
  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<MyUser> createUser(
      {required String uid,
      required String name,
      required String email,
      required String explanation}) async {
    final docUser = _usersCollection.doc(uid);

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

  static Future<MyUser?> getUserById(String userId) async {
    try {
      final snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        return MyUser.fromSnapshot(snapshot);
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return null;
  }

  static Stream<List<MyUser>> getUsers() {
    try {
      return _usersCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => MyUser.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  /// Returns username of the user with the given userId
  /// or 'Unknown' if the user does not exist
  static Future<String> getUsernameById(String userId) {
    if (userId.isEmpty) {
      return Future.value('Unknown');
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) => value.data()?['userName'] ?? 'Unknown');
    }
  }

  static Future<void> updateUser(
      {required String userId,
      required String field,
      required dynamic value}) async {
    final docUser = _usersCollection.doc(userId);

    final json = {
      'userId': docUser.id,
      field: value,
    };

    await docUser.update(json).then((value) => logger.i('User updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  static Future<void> updateUserExplanation(
      {required String userId, required String explanation}) async {
    final docUser = _usersCollection.doc(userId);

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
    final docUser = _usersCollection.doc(userId);

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
    final docUser = _usersCollection.doc(userId);

    final json = {
      'userId': docUser.id,
      'userName': name,
    };

    // create document and write data to Firebase
    await docUser.update(json).then((value) => logger.i('User Name updated'),
        onError: (error) => logger.e('Failed to update user: $error'));
  }

  /// This method do not sign out the user
  static void deleteUser(MyUser user) async {
    try {
      await _usersCollection.doc(user.userId).delete();
    } catch (e) {
      logger.e('Error: $e');
    }
  }
}
