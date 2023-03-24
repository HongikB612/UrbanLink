import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/widgets/post_list_component.dart';
import 'package:urbanlink_project/pages/postpage/postingpage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<String> posts = List.empty(growable: true);
  var userImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postListComponent = PostListComponent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: postListComponent.postStreamBuilder(
              PostDatabaseService.getPosts(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인이 필요합니다.'),
              ),
            );
            return;
          }
          var picker = ImagePicker();
          var image = await picker.pickImage(source: ImageSource.gallery);
          //추후에 pickMultiImage로 바꾸기
          if(image != null) {
            setState(() {
              userImage = image.path;
            });
          }

          Get.to(const PostingPage(), arguments: userImage);
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }
}
