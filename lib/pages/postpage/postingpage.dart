import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: controller.value.text);
              },
              child: const Text('게시하기'),
            ),
          ],
        ),
      ),
    );
  }
}
