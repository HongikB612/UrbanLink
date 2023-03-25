import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/services/posting_service.dart';
import 'package:urbanlink_project/widgets/location_searchbar_widget.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> images = List.empty(growable: true);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String headline = '';
    String content = '';
    String location = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
              children: <Widget>[
                TextFieldWidget(
                    label: '제목',
                    text: '',
                    onChanged: (headlinecontroller) {
                      headline = headlinecontroller;
                    }),
                const SizedBox(height: 10),
                TextFieldWidget(
                    label: '내용',
                    text: '',
                    maxLines: 10,
                    onChanged: (contentcontroller) {
                      content = contentcontroller;
                    }),
                const SizedBox(height: 10),
                // image upload button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () async {
                          try {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              images.add(pickedFile.path);
                            }
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                        icon: const Icon(Icons.image)),
                  ],
                ),
                const SizedBox(height: 10),
                // image preview list
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: 100,
                        child: Image.file(images[index] as File),
                      );
                    },
                  ),
                ),
                LocationSearchbar(
                  onChanged: (value) {
                    location = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    final locationId = location;
                    if (FirebaseAuth.instance.currentUser == null) {
                      Get.snackbar('로그인이 필요합니다.', '로그인 후 이용해주세요.');
                      return;
                    }
                    if (headline.isEmpty) {
                      Get.snackbar('제목을 입력해주세요.', '제목을 입력해주세요.');
                      return;
                    }
                    if (content.isEmpty) {
                      Get.snackbar('내용을 입력해주세요.', '내용을 입력해주세요.');
                      return;
                    }
                    if (location.isEmpty) {
                      Get.snackbar('위치를 입력해주세요.', '위치를 입력해주세요.');
                      return;
                    }
                    final myUser = await UserDatabaseService.getUserById(
                        FirebaseAuth.instance.currentUser!.uid);

                    const communityId = '';
                    PostingService.postingByPosts(
                        myUser!, content, headline, communityId, locationId);

                    Get.back();
                  },
                  child: const Text('게시하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
