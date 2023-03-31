import 'dart:io';

import 'package:urbanlink_project/models/user/user.dart';
import 'package:urbanlink_project/database/post_database_service.dart';

class PostingService {
  static postingByPosts(MyUser myUser, String content, String headline,
      String communityId, String locationId, List<File>? postImages) {
    PostDatabaseService.createPost(
      communityId: communityId,
      postAuthorId: myUser.userId,
      postContent: content,
      locationId: locationId,
      postCreatedTime: DateTime.now(),
      postLastModified: DateTime.now(),
      postTitle: headline,
      authorName: myUser.userName,
      postImages: postImages,
    );
  }
}
