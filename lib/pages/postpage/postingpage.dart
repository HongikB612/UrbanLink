import 'package:address_search_field/address_search_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/repositories/user_database_service.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/services/posting_service.dart';
import 'package:urbanlink_project/services/user_location_service.dart';
import 'package:urbanlink_project/widgets/location_search_dialog.dart';
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
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: '위치 검색',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              final query = _searchController.text;
                              final results =
                                  await UserLocatonService.searchLocation(
                                      query);
                              if (results.isNotEmpty) {
                                try {
                                  final selectedLocation =
                                      await showDialog<String>(
                                    context: context,
                                    builder: (context) => LocationSearchDialog(
                                      onSelected: (value) => {},
                                    ),
                                  );
                                  if (selectedLocation != null) {
                                    setState(() {
                                      _selectedLocation = selectedLocation;
                                    });
                                  }
                                } catch (e) {
                                  logger.e(e);
                                  Get.snackbar('에러가 발생했습니다.', '다시 시도해주세요.');
                                  Get.back();
                                }
                              } else {
                                Get.snackbar('검색 결과가 없습니다.', '다른 검색어를 입력해주세요.');
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(_selectedLocation),
                    const Spacer(),
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
                          PostingService.postingByPosts(myUser!, content,
                              headline, communityId, locationId);
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
            ],
          ),
        ),
      ),
    );
  }
}
