import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  TextEditingController headlineController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;
                final MyUser? myUser =
                    await UserDatabaseService.getUserById(user?.uid ?? '');
                if (myUser != null) {
                  PostDatabaseService.createPost(
                    communityId: '',
                    postAuthorId: user?.uid ?? '',
                    postContent: contentController.text,
                    locationId: '',
                    postCreatedTime: DateTime.now(),
                    postLastModified: DateTime.now(),
                    postTitle: headlineController.text,
                    authorName: myUser.userName,
                  );
                }
                Get.back();
              },
              child: const Text('게시하기'),
            ),
          ],
        ),
      ),
    );
  }
}
