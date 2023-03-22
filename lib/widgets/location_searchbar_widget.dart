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

      //   List<Placemark> placemarks =
      //     await placemarkFromCoordinates(position.latitude, position.longitude);
      // Placemark placemark = placemarks[0];
      // String formattedAddress = '${placemark.locality}, ${placemark.country}';

      List<String> locationList = [];
      for (int i = 0; i < locations.length; i++) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            locations[i].latitude, locations[i].longitude);
        Placemark placemark = placemarks[0];
        String formattedAddress =
            '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
        locationList.add(formattedAddress);
      }

      setState(() {
        _locationList = locationList;
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 16),
              Expanded(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _locationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final location = _locationList[index];

                      return ListTile(
                        title: Text(location),
                        onTap: () {
                          _selectLocation(context, location);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectLocation(BuildContext context, String location) {
    // Perform action when a location is selected
    Navigator.of(context).pop();
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _showSearchDialog(context),
          child: const Text('Search Location'),
        ),
      ],
    );
  }
}
