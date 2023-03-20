import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';

class LocationSearchbar extends StatefulWidget {
  const LocationSearchbar({Key? key}) : super(key: key);

  @override
  State<LocationSearchbar> createState() => _LocationSearchbarState();
}

class _LocationSearchbarState extends State<LocationSearchbar> {
  List<String> _locationList = [];

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      List<String> locationList = [];
      for (int i = 0; i < locations.length; i++) {
        locationList.add(locations[i].toString());
      }

      setState(() {
        _locationList = locationList;
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: '위치를 입력하세요.',
            icon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          ),
          keyboardType: TextInputType.text,
          onChanged: (text) {
            _searchLocation(text);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _locationList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_locationList[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
