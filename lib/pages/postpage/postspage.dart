import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/components/post_list_component.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
  }

  PostListComponent postListComponent = PostListComponent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postListComponent.postStreamBuilder(PostDatabaseService.getPosts()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인이 필요합니다.'),
              ),
            );
            return;
          }
          _addNavigation(context);
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }

  void _addNavigation(BuildContext context) async {
    Get.to(const PostingPage());
  }
}
