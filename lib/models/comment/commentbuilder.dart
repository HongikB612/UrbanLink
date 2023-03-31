import 'package:urbanlink_project/models/comment/comment.dart';

class CommentBuilder {
  String _commentId = '';
  String _commentAuthorId = '';
  String _commentContent = '';
  String _postId = '';
  DateTime _commentDatetime = DateTime.now();

  CommentBuilder setCommentId(String commentId) {
    _commentId = commentId;
    return this;
  }

  CommentBuilder setCommentAuthorId(String commentAuthorId) {
    _commentAuthorId = commentAuthorId;
    return this;
  }

  CommentBuilder setCommentContent(String commentContent) {
    _commentContent = commentContent;
    return this;
  }

  CommentBuilder setPostId(String postId) {
    _postId = postId;
    return this;
  }

  CommentBuilder setCommentDatetime(DateTime commentDatetime) {
    _commentDatetime = commentDatetime;
    return this;
  }

  Comment build() {
    return Comment(
      commentId: _commentId,
      commentAuthorId: _commentAuthorId,
      commentContent: _commentContent,
      postId: _postId,
      commentDatetime: _commentDatetime,
    );
  }
}
