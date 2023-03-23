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
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.soap),
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
                      height: 300,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        post.postContent,
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 0.1,),
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
                            );},
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
                            return result;},
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, thickness: 0.1,),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white70,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              child: Text("이름"),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("이름"),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text("댓글"),
                              )
                            ],
                          ),
                        ],
                      )
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
