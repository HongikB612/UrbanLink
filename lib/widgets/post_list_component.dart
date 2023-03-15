import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';

class PostListComponent {
  Widget _buildPost(Post post) {
    return StreamBuilder<MyUser?>(
      stream: UserDatabaseService.getUserStreamById(post.postAuthorId),
      builder: (context, snapshot) {
        final authorName = snapshot.data?.userName ?? 'Unknown';
        return ListTile(
          title: Text(
            post.postTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.postContent,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
          onTap: () {
            Get.to(() => const PostedPage(), arguments: post);
          },
        );
      },
    );
  }

  StreamBuilder<List<Post>> postStreamBuilder(Stream<List<Post>>? function) {
    return StreamBuilder<List<Post>>(
      stream: function,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          logger.e(snapshot.error ?? 'Unknown error');
          return Center(
            child: Text('Error: ${snapshot.error ?? 'Unknown error'}'),
          );
        } else if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return _buildPost(posts[index]);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
