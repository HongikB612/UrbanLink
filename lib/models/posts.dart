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
  });
  final String postId;
  final String postTitle;
  final String postContent;
  final String postAuthorId;
  String communityId;
  String locationId;
  final DateTime postCreatedTime;
  final String authorName;

  int postLikeCount = 0;

  /// If the post is modified, this value should be updated
  DateTime postLastModified;

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
    };
  }

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      communityId: data['communityId'] ?? 'Unknown',
      locationId: data['locationId'] ?? 'Unknown',
      postAuthorId: data['postAuthorId'] ?? 'Unknown',
      postContent: data['postContent'] ?? 'Unknown',
      postCreatedTime: DateTime.parse(data['postCreatedTime']),
      postLastModified: DateTime.parse(data['postLastModified']),
      postId: data['postId'] ?? 'Unknown',
      postTitle: data['postTitle'] ?? 'Unknown',
      authorName: data['authorName'] ?? 'Unknown',
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
        other.postLikeCount == postLikeCount;
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
        postLikeCount.hashCode;
  }
}
