import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/models/posts.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:urbanlink_project/repositories/post_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';

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

  Widget buildPost(Post post) {
    return ListTile(
      title: Text(
        post.postTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          post.postContent,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
        Row(
          children: [
            Text(
              post.authorName,
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
      ]),
      onTap: () {
        Get.to(() => const PostedPage(), arguments: post);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostDatabaseService.getPosts(),
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
                return buildPost(posts[index]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
