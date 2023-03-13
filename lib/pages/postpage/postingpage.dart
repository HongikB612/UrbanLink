import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController headlineController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    // user
    late User user;
    if (FirebaseAuth.instance.currentUser != null) {
      user = FirebaseAuth.instance.currentUser!;
    } else {
      Get.back(result: '로그인이 필요합니다.');
    }

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
                PostDatabaseService.createPost(
                  communityId: '',
                  postAuthorId: user.uid,
                  postContent: contentController.text,
                  locationId: '',
                  postCreatedTime: DateTime.now(),
                  postLastModified: DateTime.now(),
                  postTitle: headlineController.text,
                );
                Get.back(result: '게시글이 등록되었습니다.');
              },
              child: const Text('게시하기'),
            ),
          ],
        ),
      ),
    );
  }
}
