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

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentAuthorId': commentAuthorId,
      'commentContent': commentContent,
      'postId': postId,
      'commentDatetime': commentDatetime,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
      commentId: data['commentId'] ?? 'Unknown',
      commentAuthorId: data['commentAuthorId'] ?? 'Unknown',
      commentContent: data['commentContent'] ?? '',
      postId: data['postId'] ?? '',
      commentDatetime: data['commentDatetime'] ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.commentId == commentId &&
        other.commentAuthorId == commentAuthorId &&
        other.commentContent == commentContent &&
        other.postId == postId &&
        other.commentDatetime == commentDatetime;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        commentAuthorId.hashCode ^
        commentContent.hashCode ^
        postId.hashCode ^
        commentDatetime.hashCode;
  }

  @override
  String toString() {
    return 'Comment(commentId: $commentId, commentAuthorId: $commentAuthorId, commentContent: $commentContent, postId: $postId, commentDatetime: $commentDatetime)';
  }
}
