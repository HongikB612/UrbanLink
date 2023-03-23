import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/models/posts.dart';

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
          body: Card(
            child: ListTile(
              title: Text(
                post.postTitle,
              ),
              subtitle: Column(
                children: [
                  Text(
                    post.postContent,
                  ),
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
          ),
        );
      },
    );
  }
}
