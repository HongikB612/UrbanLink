import 'package:urbanlink_project/models/post/post.dart';

class PostBuilder {
  String _postId = '';
  String _postTitle = '';
  String _postContent = '';
  String _postAuthorId = '';
  String _communityId = '';
  String _locationId = '';
  DateTime _postCreatedTime = DateTime.now();
  String _authorName = '';
  DateTime _postLastModified = DateTime.now();

  int postLikeCount = 0;
  int postDislikeCount = 0;

  PostBuilder setPostId(String postId) {
    _postId = postId;
    return this;
  }

  PostBuilder setPostTitle(String postTitle) {
    _postTitle = postTitle;
    return this;
  }

  PostBuilder setPostContent(String postContent) {
    _postContent = postContent;
    return this;
  }

  PostBuilder setPostAuthorId(String postAuthorId) {
    _postAuthorId = postAuthorId;
    return this;
  }

  PostBuilder setCommunityId(String communityId) {
    _communityId = communityId;
    return this;
  }

  PostBuilder setLocationId(String locationId) {
    _locationId = locationId;
    return this;
  }

  PostBuilder setPostCreatedTime(DateTime postCreatedTime) {
    _postCreatedTime = postCreatedTime;
    return this;
  }

  PostBuilder setPostLastModifiedTime(DateTime postLastModified) {
    _postLastModified = postLastModified;
    return this;
  }

  PostBuilder setAuthorName(String authorName) {
    _authorName = authorName;
    return this;
  }

  PostBuilder setPostLikeCount(int postLikeCount) {
    this.postLikeCount = postLikeCount;
    return this;
  }

  PostBuilder setPostDislikeCount(int postDislikeCount) {
    this.postDislikeCount = postDislikeCount;
    return this;
  }

  Post build() {
    return Post(
      postId: _postId,
      postTitle: _postTitle,
      postContent: _postContent,
      postAuthorId: _postAuthorId,
      communityId: _communityId,
      locationId: _locationId,
      postCreatedTime: _postCreatedTime,
      postLastModified: _postLastModified,
      authorName: _authorName,
      postLikeCount: postLikeCount,
      postDislikeCount: postDislikeCount,
    );
  }
}
