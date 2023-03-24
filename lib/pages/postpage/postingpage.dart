import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/user_database_service.dart';
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
  var userImage = Get.arguments;

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
                Container(
                    padding:
                    EdgeInsets.zero,
                    height: 300,
                    width: 300,
                    child: Image.network(userImage)
                ),
                TextFieldWidget(
                    label: '내용',
                    text: '',
                    maxLines: 10,
                    onChanged: (contentcontroller) {
                      content = contentcontroller;
                    }),
                const SizedBox(height: 10),
                LocationSearchbar(
                  onChanged: (value) {
                    location = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    final locationId = location;
                    if (FirebaseAuth.instance.currentUser != null) {
                      final myUser = await UserDatabaseService.getUserById(
                          FirebaseAuth.instance.currentUser!.uid);

                      const communityId = '';
                      PostingService.postingByPosts(
                          myUser!, content, headline, communityId, locationId);
                    } else {
                      Get.snackbar('로그인이 필요합니다.', '로그인 후 이용해주세요.');
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
