
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/comment/comment.dart';

/// Post model
/// This model is used to store the post information
class Post {
  Post({
    required this.postId,
    required this.postTitle,
    required this.postContent,
    required this.postAuthorId,
    required this.communityId,
    required this.postLastModified,
    required this.postCreatedTime,
    required this.locationId,
    required this.authorName,
    this.postLikeCount = 0,
    this.postDislikeCount = 0,
  });
  final String postId;
  final String postTitle;
  final String postContent;
  final String postAuthorId;
  String communityId;
  String locationId;
  final DateTime postCreatedTime;
  final String authorName;

  int postLikeCount;
  int postDislikeCount;

  /// If the post is modified, this value should be updated
  DateTime postLastModified;

  List<Comment> comments = [];

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'postTitle': postTitle,
      'postContent': postContent,
      'postAuthorId': postAuthorId,
      'communityId': communityId,
      'locationId': locationId,
      'postCreatedTime': postCreatedTime.toString(),
      'postLastModified': postLastModified.toString(),
      'postLikeCount': postLikeCount,
      'postDislikeCount': postDislikeCount,
      'authorName': authorName,
    };
  }

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      communityId: data['communityId'] ?? 'Unknown',
      locationId: data['locationId'] ?? 'Unknown',
      postAuthorId: data['postAuthorId'] ?? 'Unknown',
      postContent: data['postContent'] ?? 'Unknown',
      postCreatedTime:
          DateTime.parse(data['postCreatedTime'] ?? DateTime.now().toString()),
      postLastModified:
          DateTime.parse(data['postLastModified'] ?? DateTime.now().toString()),
      postId: data['postId'] ?? 'Unknown',
      postTitle: data['postTitle'] ?? 'Unknown',
      authorName: data['authorName'] ?? 'Unknown',
      postLikeCount: data['postLikeCount'] ?? 0,
      postDislikeCount: data['postDislikeCount'] ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postId == postId &&
        other.postTitle == postTitle &&
        other.postContent == postContent &&
        other.postAuthorId == postAuthorId &&
        other.communityId == communityId &&
        other.locationId == locationId &&
        other.postCreatedTime == postCreatedTime &&
        other.postLastModified == postLastModified &&
        other.postLikeCount == postLikeCount &&
        other.postDislikeCount == postDislikeCount;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        postTitle.hashCode ^
        postContent.hashCode ^
        postAuthorId.hashCode ^
        communityId.hashCode ^
        locationId.hashCode ^
        postCreatedTime.hashCode ^
        postLastModified.hashCode ^
        postLikeCount.hashCode ^
        postDislikeCount.hashCode;
  }

  @override
  String toString() {
    return 'Post(postId: $postId, postTitle: $postTitle, postContent: $postContent, postAuthorId: $postAuthorId, communityId: $communityId, locationId: $locationId, postCreatedTime: $postCreatedTime, postLastModified: $postLastModified, postLikeCount: $postLikeCount)';
  }

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    return Post.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
