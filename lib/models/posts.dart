/// Post model
/// This model is used to store the post information
class Post {
  Post({
    required this.postId,
    required this.postTitle,
    required this.postContent,
    required this.postAuthorId,
    required this.communityId,
    required this.postDatetime,
    this.postLastModified,
  });
  final int postId;
  final String postTitle;
  final String postContent;
  final int postAuthorId;
  final int communityId;
  final DateTime postDatetime;

  /// If the post is modified, this value should be updated
  DateTime? postLastModified;
}
