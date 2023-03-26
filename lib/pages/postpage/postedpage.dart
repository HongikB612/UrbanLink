import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/comment_database_service.dart';
import 'package:urbanlink_project/database/storage_service.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/models/comments.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/widgets/comment_widget.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';
import 'package:urbanlink_project/widgets/like_button.dart';

class PostedPage extends StatefulWidget {
  const PostedPage({super.key});

  @override
  State<PostedPage> createState() => _PostedPageState();
}

class _PostedPageState extends State<PostedPage> {
  String _comment = '';
  List<String> images = List.empty(growable: true);
  bool isLoading = true;

  void _fetchImages() async {
    final Post post = Get.arguments;
    var imgs = await StorageService.getImagesByPostId(post.postId);
    setState(() {
      images = imgs;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('게시물'),
          backgroundColor: const Color.fromARGB(250, 63, 186, 219),
          shadowColor: Colors.grey,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final Post post = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Post'),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
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
                                  '${post.postCreatedTime.month}/${post
                                      .postCreatedTime.day}/${post
                                      .postCreatedTime.year}',
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
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          post.postContent,
                        ),
                      ),
                      // image list
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200,
                              height: 200,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Image.network(
                                          images[index],
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Image.network(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
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
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.1,
                ),
                // 댓글 입력창
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          hintText: '댓글을 입력하세요',
                          onChanged: (value) {
                            setState(() {
                              _comment = value;
                            });
                          },
                          label: '댓글',
                          text: _comment,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          if (_comment.isNotEmpty) {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user == null) {
                              Get.snackbar('로그인을 해야 합니다', '');
                              return;
                            }
                            final comment = Comment(
                              commentId: '',
                              commentAuthorId: user.uid,
                              commentContent: _comment,
                              commentDatetime: DateTime.now(),
                              postId: post.postId,
                            );
                            await CommentDatabaseService.createComment(comment);
                            setState(() {
                              _comment = '';
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  //댓글창
                  child: StreamBuilder<List<Comment>>(
                      stream: CommentDatabaseService.getCommentsByPostId(
                          post.postId),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          logger.e(snapshot.error ?? 'Unknown error');
                          return Center(
                            child: Text(
                                'Error: ${snapshot.error ?? 'Unknown error'}'),
                          );
                        } else if (snapshot.hasData) {
                          final comments = snapshot.data!;
                          return Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: ListView.separated(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return CommentWidget(
                                    comment: comments[index],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                }),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}