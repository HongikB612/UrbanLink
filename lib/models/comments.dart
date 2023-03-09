class Comment {
  final String commentId;
  final String commentAuthorId;
  final String commentContent;
  final String postId;
  final DateTime commentDatetime;

  Comment({
    required this.commentId,
    required this.commentAuthorId,
    required this.commentContent,
    required this.postId,
    required this.commentDatetime,
  });
}
