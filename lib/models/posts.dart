/// Post model
/// This model is used to store the post information
class Post {
  Post({
    required this.postId,
    required this.postTitle,
    required this.postContent,
    required this.postAuthorId,
    required this.communityId,
    required this.postCreatedTime,
    required this.postLastModified,
    required this.locationId,
  });
  final String postId;
  final String postTitle;
  final String postContent;
  final String postAuthorId;
  final String communityId;
  final String locationId;
  final DateTime postCreatedTime;

  int postLikeCount = 0;

  /// If the post is modified, this value should be updated
  DateTime postLastModified;
}
