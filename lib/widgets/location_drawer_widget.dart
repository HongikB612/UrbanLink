import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/community_database_service.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:urbanlink_project/models/communities.dart';
import 'package:urbanlink_project/pages/postpage/postspage.dart';

class LocationDrawerWidget extends StatefulWidget {
  const LocationDrawerWidget({
    super.key,
  });

  @override
  State<LocationDrawerWidget> createState() => _LocationDrawerWidgetState();
}

class _LocationDrawerWidgetState extends State<LocationDrawerWidget> {
  List<String> locations = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder<List<Community>>(
      stream: CommunityDatabaseService.getCommunities(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          final List<Community> communities = snapshot.data!;
          return ListView.builder(
            itemCount: communities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(communities[index].communityName),
                onTap: () {
                  Get.to(
                    () => PostsPage(
                      postStream: PostDatabaseService.getPostsByCommunityId(
                          communities[index].communityId),
                    ),
                    arguments: communities[index].communityName,
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
