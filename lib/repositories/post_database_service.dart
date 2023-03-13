import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/posts.dart';

class PostDatabaseService {
  static Future<void> createPost({
    required String postTitle,
    required String postContent,
    required String postAuthorId,
    required String communityId,
    required DateTime postCreatedTime,
    required DateTime postLastModified,
    required String locationId,
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
      'locationId': locationId,
    };

    // create document and write data to Firebase
    await docPost.set(json);
  }

  static Stream<List<Post>> getPosts() {
    return FirebaseFirestore.instance.collection('posts').snapshots().map(
        (snapshot) => snapshot.docs
            .map<Post>((doc) => Post.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<Post>> getPostsByCommunityId(String communityId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('communityId', isEqualTo: communityId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Post>((doc) => Post.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<Post>> getPostsByUserId(String userId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('postAuthorId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Post>((doc) => Post.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<Post>> getPostsByPostId(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Post>((doc) => Post.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<Post>> getPostsByPostTitle(String postTitle) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('postTitle', arrayContains: postTitle)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Post>((doc) => Post.fromJson(doc.data()))
            .toList());
  }
}
