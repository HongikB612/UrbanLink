import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urbanlink_project/database/community_database_service.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
import 'package:urbanlink_project/models/post/postbuilder.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/widgets/image_list_builder.dart';
import 'package:urbanlink_project/widgets/location_searchbar_widget.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final TextEditingController _searchController = TextEditingController();
  List<File> images = List.empty(growable: true);
  String _headline = '';
  String _content = '';
  String _location = Get.arguments ?? '';
  int maxImageCount = 10;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Posting'),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFieldWidget(
                    label: '제목',
                    text: '',
                    onChanged: (headlinecontroller) {
                      _headline = headlinecontroller;
                    }),
                const SizedBox(height: 10),
                TextFieldWidget(
                    label: '내용',
                    text: '',
                    maxLines: 10,
                    onChanged: (contentcontroller) {
                      _content = contentcontroller;
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
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              if (images.length >= maxImageCount) {
                                Get.snackbar(
                                    '사진은 $maxImageCount장까지만 등록할 수 있습니다.',
                                    '사진을 삭제하고 다시 등록해주세요.');
                                return;
                              }
                              if (mounted) {
                                setState(() {
                                  images.add(File(pickedFile.path));
                                });
                              }
                            }
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                        icon: const Icon(Icons.image)),
                    IconButton(
                        onPressed: () async {
                          try {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              setState(() {
                                images.add(File(pickedFile.path));
                              });
                            }
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                        icon: const Icon(Icons.camera_alt)),
                  ],
                ),
                const SizedBox(height: 10),
                // image preview list
                ImageListBuilder(images: images),
                const SizedBox(height: 10),
                LocationSearchbar(
                  onChanged: (value) {
                    _location = value;
                  },
                  selectedLocation: _location,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final locationId = _location;
                    if (FirebaseAuth.instance.currentUser == null) {
                      Get.snackbar('로그인이 필요합니다.', '로그인 후 이용해주세요.');
                      return;
                    }
                    if (_headline.isEmpty) {
                      Get.snackbar('제목을 입력해주세요.', '제목을 입력해주세요.');
                      return;
                    }
                    if (_content.isEmpty) {
                      Get.snackbar('내용을 입력해주세요.', '내용을 입력해주세요.');
                      return;
                    }
                    if (_location.isEmpty) {
                      Get.snackbar('위치를 입력해주세요.', '위치를 입력해주세요.');
                      return;
                    }
                    final myUser = await UserDatabaseService.getUserById(
                        FirebaseAuth.instance.currentUser!.uid);

                    final community =
                        await CommunityDatabaseService.getCommunityByLocation(
                            locationId);
                    if (myUser != null) {
                      final posting = PostBuilder()
                          .setAuthorName(myUser.userName)
                          .setPostAuthorId(
                              FirebaseAuth.instance.currentUser!.uid)
                          .setCommunityId(community.communityId)
                          .setPostTitle(_headline)
                          .setPostContent(_content)
                          .setLocationId(locationId)
                          .build();

                      await PostDatabaseService.createPost(post: posting);
                    }
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
