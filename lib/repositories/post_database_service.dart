import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostDatabaseService {
  static Future<Post> createPost({
    required String postTitle,
    required String postContent,
    required String postAuthorId,
    required String communityId,
    required DateTime postCreatedTime,
    required DateTime postLastModified,
    required String locationId,
    required String authorName,
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
      'authorName': authorName,
      'postLikeCount': 0,
      'postDislikeCount': 0,
    };

    // create document and write data to Firebase
    await docPost.set(json);

    // return Post object with generated postId
    return Post(
      postId: docPost.id,
      postTitle: postTitle,
      postContent: postContent,
      postAuthorId: postAuthorId,
      communityId: communityId,
      postCreatedTime: postCreatedTime,
      postLastModified: postLastModified,
      locationId: locationId,
      authorName: authorName,
    );
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

  static Future<void> updatePost(
      {required String postId,
      required String field,
      required dynamic value}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      field: value,
      'postLastModified': postModifiedTime.toString(),
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostContent(
      {required String postId, required String postContent}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'postContent': postContent,
      'postLastModified': postModifiedTime.toString(),
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post Content updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostTitle(
      {required String postId, required String postTitle}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'postTitle': postTitle,
      'postLastModified': postModifiedTime.toString(),
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post Title updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostLocationId(
      {required String postId, required String locationId}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'locationId': locationId,
      'postLastModified': postModifiedTime.toString(),
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Location updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostLikeCount(
      {required String postId, required int postLikeCount}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);

    final json = {
      'postId': docPost.id,
      'postLikeCount': postLikeCount,
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Like Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostDislikeCount(
      {required String postId, required int postDislikeCount}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);

    final json = {
      'postId': docPost.id,
      'postDislikeCount': postDislikeCount,
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Dislike Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> deletePost({required String postId}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(postId);

    await docPost.delete().then((value) => logger.i('Post deleted'),
        onError: (error) => logger.e('Failed to delete post: $error'));
  }
}
