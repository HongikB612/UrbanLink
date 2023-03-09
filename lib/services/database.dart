import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  static Future<void> createUser(
      {required String uid,
      required String name,
      required String email}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final json = {
      'userId': docUser.id,
      'userName': name,
      'userEmail': email,
      'userExplanation': '',
    };

    // create document and write data to Firebase
    await docUser.set(json);
  }

  static Future<void> createPost({
    required String postTitle,
    required String postContent,
    required String postAuthorId,
    required String communityId,
    required DateTime postCreatedTime,
    required DateTime postLastModified,
  }) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    final json = {
      'postId': docPost.id,
      'postTitle': postTitle,
      'postContent': postContent,
      'postAuthorId': postAuthorId,
      'communityId': communityId,
      'postCreatedTime': postCreatedTime.toString(),
      'postLastModified': postLastModified.toString(),
    };

    // create document and write data to Firebase
    await docPost.set(json);
  }
}
