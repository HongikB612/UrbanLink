import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/comments.dart';
import 'package:urbanlink_project/services/auth.dart';

class CommentDatabaseService {
  static final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  static Stream<List<Comment>> getCommentsByPostId(String postId) {
    final docPost = _postsCollection.doc(postId);
    try {
      return docPost
          .collection('comments')
          .orderBy('commentDate', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Comment.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }

  static createComment(Comment comment) {
    final docPost = _postsCollection.doc(comment.postId);
    final docComment = docPost.collection('comments').doc();

    final json = {
      'commentId': docComment.id,
      'commentAuthorId': comment.commentAuthorId,
      'commentContent': comment.commentContent,
      'commentDate': comment.commentDatetime.toString(),
      'postId': comment.postId,
    };
    try {
      docComment.set(json);
    } catch (e) {
      logger.e('Error: $e');
    }
  }
}
