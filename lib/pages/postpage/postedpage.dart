import 'package:flutter/material.dart';

class PostedPage extends StatelessWidget {
  const PostedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: const Center(
        child: Text(
          '게시글입니다.',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
