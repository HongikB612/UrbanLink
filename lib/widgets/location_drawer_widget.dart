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
  List<String> locations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.builder(
      itemCount: locations.length,
      itemBuilder: (c, i) => Card(
        child: ListTile(
          title: Text(locations[i]),
          onTap: () {
            Get.to(() => const PostsPage(), arguments: locations[i]);
          },
        ),
      ),
    ));
  }
  
  Future<void> _getLocations() async {
    
  }
}
