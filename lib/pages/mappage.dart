import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    super.key,
  });

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
        Image(image: AssetImage('assets/images/GoogleMapTA.jpeg')),
      ],
    ));
  }
}
