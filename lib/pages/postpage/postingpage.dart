import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController headlineController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목',
              ),
              controller: headlineController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
              ),
              controller: contentController,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Post post = Post(
                  communityId: '',
                  postContent: contentController.text,
                  postTitle: headlineController.text,
                  postAuthorId: '',
                  locationId: '',
                  postCreatedTime: DateTime.now(),
                  postLastModified: DateTime.now(),
                  postId: '',
                );
                PostDatabaseService.createPost(post);
                Get.back(result: headlineController.text);
              },
              child: const Text('게시하기'),
            ),
          ],
        ),
      ),
    );
  }
}
