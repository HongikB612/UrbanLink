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
              Container(  //게시물
                padding: const EdgeInsets.all(30),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(  //게시자 정보
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
                    Container(  //게시 내용
                      height: 300,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        post.postContent,
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 0.1,),
                    Row(   //좋아요 버튼
                      children: <Widget>[
                        LikeButton(
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
                    const Divider(color: Colors.grey, thickness: 0.1,),
                  ],
                ),
              ),
              Expanded(  //댓글창
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(5, 3, 30, 0),
                        color: Colors.white70,
                        child: Row(
                          children: <Widget>[
                            Container(  //누리꾼 정보
                              margin: const EdgeInsets.all(5),
                              child: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                child: Icon(Icons.abc_sharp),
                              ),
                            ),
                            Column(   //댓글 내용
                              children: <Widget>[
                                const Text("이름", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: const Text("댓글", style: TextStyle(fontSize: 13)),
                                ),
                              ],
                            ),
                          ],
                        )
                      );},
                      separatorBuilder: (BuildContext ctx, int dix) {
                        return const Divider();
                      }
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
