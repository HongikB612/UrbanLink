import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/services/posting_service.dart';
import 'package:urbanlink_project/services/user_location_service.dart';
import 'package:urbanlink_project/widgets/location_searchbar_widget.dart';
import 'package:urbanlink_project/widgets/text_fieldwidget.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedLocation = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String headline = '';
    String content = '';
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
                const LocationSearchbar(),
                ElevatedButton(
                  onPressed: () async {
                    late Position currentPosition;
                    late String currentAddress;
                    try {
                      currentPosition =
                          await UserLocatonService.getCurrentLocation();
                      currentAddress =
                          await UserLocatonService.getCurrentAddress(
                              currentPosition);
                    } catch (e) {
                      logger.e(e);
                      currentAddress = '위치 정보를 가져올 수 없습니다.';
                    }

                    final locationId = _selectedLocation.isNotEmpty
                        ? _selectedLocation
                        : currentAddress;

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
