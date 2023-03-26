import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/postpage/postspage.dart';

class LocationDrawerWidget extends StatefulWidget {
  const LocationDrawerWidget({
    super.key,
  });

  @override
  State<LocationDrawerWidget> createState() => _LocationDrawerWidgetState();
}

class _LocationDrawerWidgetState extends State<LocationDrawerWidget> {
  List<String> fakeLocations = [
    "서울 마포구 창천동",
    "서울 마포구 동교동",
    "서울 서대문구 창천동",
    "서울 마포구 서강동",
    "서울 마포구 노고산동",
    "서울 마포구 서교동",
    "서울 마포구 상수동",
    "서울 마포구 신수동",
    "서울 마포구 구수동",
    "서울 마포구 하중동",
    "서울 마포구 신정동",
    "서울 마포구 대흥동",
    "서울 마포구 연남동",
    "서울 마포구 현석동",
    "서울 마포구 당인동",
    "서울 마포구 용강동",
    "서울 서대문구 대현동",
    "서울 서대문구 신촌동",
    "서울 마포구 염리동",
    "서울 서대문구 대신동",
    "서울 마포구 토정동",
    "서울 마포구 망원제1동",
    "서울 마포구 합정동",
    "서울 마포구 성산제1동"
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.builder(
      itemCount: fakeLocations.length,
      itemBuilder: (c, i) => Card(
        child: ListTile(
          title: Text(fakeLocations[i]),
          onTap: () {
            Get.to(() => const PostsPage(), arguments: fakeLocations[i]);
          },
        ),
      ),
    ));
  }
}
