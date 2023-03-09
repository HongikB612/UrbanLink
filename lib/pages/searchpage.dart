import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/pages/mappage/mappage.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            onPressed: () {
              Get.to(() => const MapPage());
            },
            icon: const Icon(Icons.map),
          ),
        )
      ],
    ));
  }
}
