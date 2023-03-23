import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:like_button/like_button.dart';

class PostedPage extends StatelessWidget {
  const PostedPage({super.key});
  @override
  Widget build(BuildContext context) {
    final post = Get.arguments;
    return StreamBuilder<MyUser?>(
      stream: UserDatabaseService.getUserStreamById(post.postAuthorId),
      builder: (context, snapshot) {
        final authorName = snapshot.data?.userName ?? 'Unknown';
        return Scaffold(
          body: Column(
            children: [
              Card(
                color: Colors.brown,
                child: Column(
                  children: <Widget>[
                    ListTile(
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
                          Text(
                            post.postContent,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        LikeButton(
                          circleColor:
                          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.pinkAccent : Colors.grey,
                            );
                          },
                          likeCount: 665,
                          countBuilder: (int? count, bool isLiked, String text) {
                            final ColorSwatch<int> color = isLiked ? Colors.pinkAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "love",
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text("댓글"),
                    );},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
