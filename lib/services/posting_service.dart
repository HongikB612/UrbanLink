
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';

class PostingService {
  static postingByPosts(MyUser myUser, String content, String headline,
      String communityId, String locationId) {
    PostDatabaseService.createPost(
      communityId: communityId,
      postAuthorId: myUser.userId,
      postContent: content,
      locationId: locationId,
      postCreatedTime: DateTime.now(),
      postLastModified: DateTime.now(),
      postTitle: headline,
      authorName: myUser.userName,
    );
  }
}
