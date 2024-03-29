import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanlink_project/database/storage_service.dart';
import 'package:urbanlink_project/models/post/post.dart';
import 'package:urbanlink_project/models/post/postbuilder.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostDatabaseService {
  static final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  static Future<Post> createPost({
    required Post post,
    List<File>? postImages,
  }) async {
    final docPost = _postsCollection.doc();

    if (postImages != null && postImages.isNotEmpty) {
      await StorageService.uploadPostImages(
          postId: docPost.id, images: postImages);
    }

    final json = {
      'postId': docPost.id,
      'postTitle': post.postTitle,
      'postContent': post.postContent,
      'postAuthorId': post.postAuthorId,
      'communityId': post.communityId,
      'postCreatedTime': post.postCreatedTime.toString(),
      'postLastModified': post.postLastModified.toString(),
      'locationId': post.locationId,
      'authorName': post.authorName,
      'postLikeCount': 0,
      'postDislikeCount': 0,
    };

    // create document and write data to Firebase
    await docPost.set(json);
    docPost.collection('comments').doc();

    // return Post object with generated postId
    return PostBuilder()
        .setPostId(docPost.id)
        .setPostTitle(post.postTitle)
        .setPostContent(post.postContent)
        .setAuthorName(post.authorName)
        .setPostAuthorId(post.postAuthorId)
        .setCommunityId(post.communityId)
        .setPostCreatedTime(post.postCreatedTime)
        .setPostLastModifiedTime(post.postLastModified)
        .setLocationId(post.locationId)
        .build();
  }

  static Stream<List<Post>> getPosts() {
    try {
      return _postsCollection
          .orderBy('postCreatedTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Stream<List<Post>> getPostsByCommunityId(String communityId) {
    try {
      return _postsCollection
          .where('communityId', isEqualTo: communityId)
          .orderBy('postCreatedTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Stream<List<Post>> getPostsByUserId(String userId) {
    try {
      return _postsCollection
          .where('postAuthorId', isEqualTo: userId)
          .orderBy('postCreatedTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Stream<List<Post>> getPostsByPostId(String postId) {
    try {
      return _postsCollection
          .where('postId', isEqualTo: postId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Stream<List<Post>> getPostsByPostTitle(String postTitle) {
    try {
      return _postsCollection
          .where('postTitle', isEqualTo: postTitle)
          .orderBy('postCreatedTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Stream<List<Post>> getPostsByUserIdAndCommunityId(
      String userId, String communityId) {
    try {
      return _postsCollection
          .where('postAuthorId', isEqualTo: userId)
          .where('communityId', isEqualTo: communityId)
          .orderBy('postCreatedTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static Future<void> updatePost(
      {required String postId,
      required String field,
      required dynamic value}) async {
    if (field == 'postAuthorId' || field == 'postId') {
      logger.e('Cannot update postAuthorId or postId');
      throw Exception('Cannot update postAuthorId or postId');
    }
    final docPost = _postsCollection.doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      field: value,
      'postLastModified': postModifiedTime.toString(),
      'postAuthorName': FirebaseAuth.instance.currentUser!.displayName,
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostContent(
      {required String postId, required String postContent}) async {
    final docPost = _postsCollection.doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'postContent': postContent,
      'postLastModified': postModifiedTime.toString(),
      'postAuthorName': FirebaseAuth.instance.currentUser!.displayName,
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post Content updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostTitle(
      {required String postId, required String postTitle}) async {
    final docPost = _postsCollection.doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'postTitle': postTitle,
      'postLastModified': postModifiedTime.toString(),
      'postAuthorName': FirebaseAuth.instance.currentUser!.displayName,
    };

    // create document and write data to Firebase
    await docPost.update(json).then((value) => logger.i('Post Title updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostLocationId(
      {required String postId, required String locationId}) async {
    final docPost = _postsCollection.doc(postId);
    final postModifiedTime = DateTime.now();

    final json = {
      'postId': docPost.id,
      'locationId': locationId,
      'postLastModified': postModifiedTime.toString(),
      'postAuthorName': FirebaseAuth.instance.currentUser!.displayName,
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Location updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostLikeCount(
      {required String postId, required int postLikeCount}) async {
    final docPost = _postsCollection.doc(postId);

    final json = {
      'postId': docPost.id,
      'postLikeCount': postLikeCount,
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Like Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> increasePostLikeCount({required String postId}) async {
    final docPost = _postsCollection.doc(postId);

    final json = {
      'postId': docPost.id,
      'postLikeCount': FieldValue.increment(1),
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Like Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> decreasePostLikeCount({required String postId}) async {
    final docPost = _postsCollection.doc(postId);

    final json = {
      'postId': docPost.id,
      'postLikeCount': FieldValue.increment(-1),
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Like Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> increasePostDislikeCount({required String postId}) async {
    final docPost = _postsCollection.doc(postId);

    final json = {
      'postId': docPost.id,
      'postDislikeCount': FieldValue.increment(1),
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Dislike Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> decreasePostDislikeCount({required String postId}) async {
    final docPost = _postsCollection.doc(postId);

    final json = {
      'postId': docPost.id,
      'postDislikeCount': FieldValue.increment(-1),
    };

    // create document and write data to Firebase
    await docPost.update(json).then(
        (value) => logger.i('Post Dislike Count updated'),
        onError: (error) => logger.e('Failed to update post: $error'));
  }

  static Future<void> updatePostDislikeCount(
      {required String postId, required int postDislikeCount}) async {
    final docPost = _postsCollection.doc(postId);

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
    try {
      await _postsCollection
          .doc(postId)
          .collection('comments')
          .get()
          .then((value) {
        for (final doc in value.docs) {
          doc.reference.delete();
        }
      });
      await _postsCollection.doc(postId).delete();
    } catch (e) {
      logger.e('Error: $e');
    }
  }
}
