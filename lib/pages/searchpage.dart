import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: const [
        // search bar
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
          ),
        ),
        // list of results
        Text('Search Results'),
      ],
    ));
  }
}
