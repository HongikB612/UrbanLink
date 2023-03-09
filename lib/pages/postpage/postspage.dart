import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/postpage/postedpage.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<String> posts = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    posts.add('글1');
    posts.add('글2');
    posts.add('글3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              child: Text(
                posts[index],
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                Get.to(
                  () => const PostedPage(),
                  arguments: posts[index],
                );
              },
            ),
          );
        },
        itemCount: posts.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }

  void _addNavigation(BuildContext context) async {
    final result = await Get.to(
      () => const PostingPage(),
      arguments: '글쓰기',
    );
    setState(() {
      posts.add(result);
    });
  }
}
