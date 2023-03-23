import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:like_button/like_button.dart';
import 'package:urbanlink_project/widgets/comment_widget.dart';

class PostedPage extends StatelessWidget {
  const PostedPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Post post = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물'),
      ),
      body: StreamBuilder<MyUser?>(
        stream: UserDatabaseService.getUserStreamById(post.postAuthorId),
        builder: (context, snapshot) {
          final authorName = snapshot.data?.userName ?? 'Unknown';
          return Scaffold(
            body: Column(
              children: [
                Container(
                  //게시물
                  padding: const EdgeInsets.all(30),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        //게시자 정보
                        leading: const Icon(Icons.soap),
                        title: Text(
                          post.postTitle,
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  authorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  ' | ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${post.postCreatedTime.month}/${post.postCreatedTime.day}/${post.postCreatedTime.year}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //게시 내용
                        height: 300,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          post.postContent,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.1,
                      ),
                      Row(
                        children: <Widget>[
                          //좋아요 버튼
                          postLikeButton(post),
                          const SizedBox(
                            width: 10,
                          ),
                          // 싫어요 버튼
                          postDislikeButton(post),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  //댓글창
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ListView.separated(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const CommentWidget();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  LikeButton postDislikeButton(Post post) {
    return LikeButton(
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.thumb_down,
          color: isLiked ? Colors.pinkAccent : Colors.grey,
        );
      },
      likeCount: post.postDislikeCount,
      countBuilder: (int? count, bool isLiked, String text) {
        final ColorSwatch<int> color =
            isLiked ? Colors.pinkAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "unlike",
            style: TextStyle(color: color),
          );
        } else {
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        }
        return result;
      },
      onTap: (isDisLiked) async {
        if (isDisLiked) {
          post.postDislikeCount--;
          PostDatabaseService.decreasePostDislikeCount(postId: post.postId);
        } else {
          post.postDislikeCount++;
          PostDatabaseService.increasePostDislikeCount(postId: post.postId);
        }
        return !isDisLiked;
      },
    );
  }

  LikeButton postLikeButton(Post post) {
    return LikeButton(
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.pinkAccent : Colors.grey,
        );
      },
      likeCount: post.postLikeCount,
      countBuilder: (int? count, bool isLiked, String text) {
        final ColorSwatch<int> color =
            isLiked ? Colors.pinkAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "love",
            style: TextStyle(color: color),
          );
        } else {
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        }
        return result;
      },
      onTap: (isLiked) async {
        if (isLiked) {
          post.postLikeCount--;
          PostDatabaseService.decreasePostDislikeCount(postId: post.postId);
        } else {
          post.postLikeCount++;
          PostDatabaseService.increasePostDislikeCount(postId: post.postId);
        }
        return !isLiked;
      },
    );
  }
}
