import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/widgets/location_drawer_widget.dart';
import 'package:urbanlink_project/widgets/post_list_widget.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:urbanlink_project/models/posts.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key, this.postStream});

  final Stream<List<Post>>? postStream;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Post post;
  List<String> posts = List.empty(growable: true);
  String location = Get.arguments ?? "location";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.grey,
      ),
      endDrawer: const LocationDrawerWidget(),
      body: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.zero,
            topRight: Radius.zero,
          ),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        elevation: 5,
        child: PostList(
          postStream: widget.postStream ?? PostDatabaseService.getPosts(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인이 필요합니다.'),
              ),
            );
            return;
          }

          Get.to(() => const PostingPage(), arguments: Get.arguments);
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }
}
