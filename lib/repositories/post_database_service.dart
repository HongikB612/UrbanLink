import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/posts.dart';

class PostDatabaseService {
  static Future<void> createPost(Post post) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    final json = {
      'postId': docPost.id,
      'postTitle': post.postTitle,
      'postContent': post.postContent,
      'postAuthorId': post.postAuthorId,
      'communityId': post.communityId,
      'postCreatedTime': post.postCreatedTime.toString(),
      'postLastModified': post.postLastModified.toString(),
    };

    post.postId = docPost.id;

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
