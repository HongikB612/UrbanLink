import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/widgets/post_list_component.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:urbanlink_project/pages/profilepage/profilepage.dart';
import 'package:urbanlink_project/widgets/like_button.dart';
import 'package:urbanlink_project/models/posts.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Post post;
  List<String> posts = List.empty(growable: true);
  String fakeLocation = Get.arguments ?? "location";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postListComponent = PostListComponent();
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Text(fakeLocation),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            onPressed: ()=>{
              Get.to(() => const ProfilePage()),
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: postListComponent.postStreamBuilder(
              PostDatabaseService.getPosts(),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인이 필요합니다.'),
              ),
            );
            return;
          }

          Get.to(const PostingPage());
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }
}
