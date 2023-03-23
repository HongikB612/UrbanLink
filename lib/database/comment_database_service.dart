import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbanlink_project/models/comments.dart';
import 'package:urbanlink_project/services/auth.dart';

class CommentDatabaseService {
  static final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  static Stream<List<Comment>> getCommentsByPostId(String postId) {
    final docPost = _postsCollection.doc(postId);
    try {
      return docPost.collection('comments').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Comment.fromSnapshot(doc))
            .toList(growable: false);
      });
    } catch (e) {
      logger.e('Error: $e');
      return const Stream.empty();
    }
  }
}
