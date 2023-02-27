class Comment {
  final int commentId;
  final int commentAuthorId;
  final DateTime commentDatetime;
  final String commentContent;

  /// postid that this comment is attached to
  final int postId;

  Comment({
    required this.commentId,
    required this.commentAuthorId,
    required this.commentDatetime,
    required this.commentContent,
    required this.postId,
  });
}
